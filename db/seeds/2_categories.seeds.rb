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
    Node.create(
      parent_node: county,
      is_category: true,
      title: category
    )
  end
end
