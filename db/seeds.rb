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

def populate_questions(county, category, questions)
  Promulgators::Node.new(
    questions,
    Node.categories.where(
      title: category,
      parent_node: Node.counties.find_by(title: county.to_s.titleize)
    ).first
  ).promulgate!
end

Promulgators::Referral.new([:special, :primary, :secondary]).promulgate!
Promulgators::Node.new([:root, :counties, :categories]).promulgate!

all_non_sf_locations = Node.counties.where.not(title: 'San Francisco')

populate_questions :san_francisco, "Benefits", [:benefits_sf_1, :benefits_sf_2]
populate_questions :san_francisco, "Criminal & Tickets", [:criminal_sf_1]
populate_questions :san_francisco, "Family & Relationships", [:family_sf_1, :family_sf_2]
populate_questions :san_francisco, "Immigration", [:immigration_sf_1]

populate_questions all_non_sf_locations, "Benefits", [:benefits_suburbs_1]