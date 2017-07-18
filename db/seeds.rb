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

Promulgators::Referral.new(files: [:special, :primary, :secondary]).promulgate!

Promulgators::Node.new(files: [:root, :counties, :categories]).promulgate!

category_tree = {
  "San Francisco": {
    "Benefits":                [:benefits_sf_1, :benefits_sf_2],
    "Criminal & Tickets":      [:criminal_sf_1],
    "Family & Relationships":  [:family_sf_1, :family_sf_2],
    "Immigration":             [:immigration_sf_1],
    "Work, Credit & Consumer": [:work_sf_1],
    "Housing":                 [:housing_sf_1, :housing_sf_2, :housing_sf_3, :housing_sf_4]
  },
  "Suburbs": {
    "Benefits":                [:benefits_suburbs_1],
    "Criminal & Tickets":      [:criminal_suburbs_1],
    "Family & Relationships":  [:family_suburbs_1],
    "Immigration":             [:immigration_suburbs_1],
    "Work, Credit & Consumer": [:work_suburbs_1],
    "Housing":                 [:housing_suburbs_1]
  }
}

Node.counties.each do |county|
  category_tree.fetch(county.title, category_tree["Other"]).each do |category, files|
    Promulgators::Node.new(path: ["County", county.title, category], files: files).promulgate!
  end
end
