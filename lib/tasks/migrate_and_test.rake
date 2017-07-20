namespace :db do
  namespace :deploy do
    class DeployTest
      STAGING_APP="tlab-pll-staging"

      def self.record_count
        # TODO fill out smoke test
        rand(1020301203122343)
      end

      def self.rollback!
        # cmd "heroku rollback -a #{STAGING_APP}"
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

      previous_record_count = DeployTest.record_count

      puts "  - Got #{previous_record_count} records "\
        "before seeding...".colorize(:yellow)

      puts "  - Seeding the db...".colorize(:yellow)

      DeployTest.suppress_output do
        Rake::Task['db:seed'].invoke
      end

      current_record_count = DeployTest.record_count
      if previous_record_count != current_record_count
        puts "==> Got #{current_record_count} records, expecting to get "\
          "#{previous_record_count} records".colorize(:red)

        puts "  - Rolling back staging to a good-enough state...".colorize(:red)

        exit! 1
      else
        puts "==> Everything looks good, allowing deploy!".colorize(:green)
      end
    end
  end
end
