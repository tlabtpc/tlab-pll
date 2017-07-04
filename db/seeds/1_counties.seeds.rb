Node.counties.destroy_all

[
  "Alameda",
  "Contra Costa",
  "Marin",
  "San Francisco",
  "San Mateo",
  "Santa Clara",
  "Other County"
].each do |county|
  Node.create(title: county,
    parent_node: Node.root,
    is_county: true,
    tip: :category
  )
end
