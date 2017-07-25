task :code_the_node => ["db:migrate", :environment] do
  CodeTheNode.add_codes!
end
