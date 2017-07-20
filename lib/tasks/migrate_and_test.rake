namespace :db do
  namespace :deploy do
    module DeployTest
      STAGING_APP="tlab-pll-staging"

      def self.record_count
        # TODO fill out smoke test
        rand(1020301203122343)
      end

      def self.rollback!
        # cmd "heroku rollback -a #{STAGING_APP}"
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

      Rake::Task['db:seed'].invoke

      current_record_count = DeployTest.record_count
      if previous_record_count != current_record_count
        puts "==> Got #{current_record_count} records, expecting to get "\
          "#{previous_record_count} records".colorize(:red)

        puts "  - Rolling back staging to a good-enough state...".colorize(:red)

        abort
      else
        puts "==> Everything looks good, allowing deploy!".colorize(:green)
      end
    end
  end
end
