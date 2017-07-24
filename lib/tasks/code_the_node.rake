task :migrate_and_test => ["db:migrate", :environment] do
  CodeTheNode.add_codes!
end
