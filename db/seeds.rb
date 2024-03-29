def create_user(email, admin)
  name = email.split("@").first.capitalize
  user = User.find_or_initialize_by(email: email)
  if user.new_record?
    puts "Creating user #{name} <#{email}>"
    user.update!(name: name, admin: admin, password: "password")
  end
end

unless ENV['AIRBRAKE_ENV'] == 'production'
  create_user("admin@example.com", true)
  create_user("member@example.com", false)
end

Promulgators::Master.new.promulgate!