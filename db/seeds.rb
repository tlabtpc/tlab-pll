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

Node.root.update(
  tip: :county,
  question: "Let's work one issue at a time. What county is the issue in?"
)

[
  "Alameda",
  "Contra Costa",
  "Marin",
  "San Francisco",
  "San Mateo",
  "Santa Clara",
  "Other County"
].each do |county|
  Node.find_or_create_by(title: county,
    parent_node: Node.root,
    is_county: true
  ).update(
    question: "Can you tell what category of legal help your client needs?",
    tip: :category
  )
end

Node.counties.each do |county|
  [
    "Benefits",
    "Criminal & Tickets",
    "Family & Relationships",
    "Housing",
    "Immigration",
    "Work, Credit & Consumer",
    "Other issues",
    "I don't know"
  ].each do |category|
    Node.find_or_create_by(
      parent_node: county,
      is_category: true,
      title: category
    )
  end
end
