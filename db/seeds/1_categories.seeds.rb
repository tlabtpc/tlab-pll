Node.categories.destroy_all

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
    Node.create(title: category, is_category: true, parent_node: county)
  end
end
