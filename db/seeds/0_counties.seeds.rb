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
  Node.create(title: county, is_county: true, parent_node: Node.root)
end
