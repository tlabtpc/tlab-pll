namespace :db do
  namespace :deploy do
    class DeployTest
      STAGING_APP="tlab-pll-staging"

      def self.hand_edited_count
        Referral.hand_edited.count
      end

      def self.missing_referrals_count
        AssessmentReferral.with_missing_referrals.count
      end

      def self.rollback!
        cmd "heroku rollback -a #{STAGING_APP}"
      end

      def self.suppress_output
        begin
          original_stderr = $stderr.clone
          original_stdout = $stdout.clone
          $stderr.reopen(File.new('/dev/null', 'w'))
          $stdout.reopen(File.new('/dev/null', 'w'))
          retval = yield
        rescue Exception => e
          $stdout.reopen(original_stdout)
          $stderr.reopen(original_stderr)
          raise e
        ensure
          $stdout.reopen(original_stdout)
          $stderr.reopen(original_stderr)
        end
        retval
      end

      private

      def self.cmd(cmd)
        puts "    - #{cmd}".colorize(:blue)
        system(cmd)
      end
    end

    task :migrate_and_test => ["db:migrate", :environment] do
      puts "==> Starting data integrity smoke test".colorize(:green)

      previous_hand_edited_count = DeployTest.hand_edited_count
      previous_missing_referrals_count = DeployTest.missing_referrals_count

      puts "  - Seeding the db...".colorize(:yellow)

      DeployTest.suppress_output do
        Rake::Task['db:seed'].invoke
      end

      needs_rollback = false

      current_hand_edited_count = DeployTest.hand_edited_count
      current_missing_referrals_count = DeployTest.missing_referrals_count

      if previous_hand_edited_count != current_hand_edited_count
        needs_rollback = true

        puts "==> Got #{current_hand_edited_count} hand edited referrals, "\
          "expecting to get #{previous_hand_edited_count} "\
          "records".colorize(:red)
      end

      if previous_missing_referrals_count != current_missing_referrals_count
        needs_rollback = true

        puts "==> Got #{current_missing_referrals_count} missing referrals, "\
          "expecting to get #{previous_missing_referrals_count} "\
          "records".colorize(:red)
      end

      if needs_rollback
        puts "  - Rolling back staging to a good-enough state...".colorize(:red)
        DeployTest.rollback!
        exit! 1
      end

      puts "==> Everything looks good, allowing deploy!".colorize(:green)
      puts "  - #{current_hand_edited_count} hand edited referrals"
        .colorize(:blue)

      puts "  - #{current_missing_referrals_count} dangling referrals"
        .colorize(:blue)
    end
  end
end
