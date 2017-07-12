def create_user(email, admin)
  name = email.split("@").first.capitalize
  user = User.find_or_initialize_by(email: email)
  if user.new_record?
    puts "Creating user #{name} <#{email}>"
    user.update!(name: name, admin: admin, password: "password")
  end
end

unless Rails.env.production?
  create_user("admin@example.com", true)
  create_user("member@example.com", false)
end

Promulgators::Node.new([:root, :counties, :categories]).promulgate!
Promulgators::Referral.new([:special, :primary]).promulgate!

san_francisco = Node.counties.find_by(title: "San Francisco")
other_locations = Node.counties.where.not(title: 'San Francisco')

Node.categories.where(title: "Benefits", parent_node: san_francisco).each do |category|
  Promulgators::Node.new([:benefits_sf_1, :benefits_sf_2], category).promulgate!
end

Node.categories.where(title: "Benefits", parent_node: other_locations).each do |category|
  Promulgators::Node.new([:benefits_suburbs_1], category).promulgate!
end