dimensions = [
  {
    root_dimension: "price",
    unit_name: "USD",
    multiply_constant: 1.0,
    unitary_role: :primary
  },
  { 
    root_dimension: "mass",
    unit_name: "pound", # assumes we're on Earth (lol)
    multiply_constant: 1.0,
    unitary_role: :primary
  },
  {
    root_dimension: "mass",
    unit_name: "ton",
    multiply_constant: 2000,
    unitary_role: :secondary
  },
  {
    root_dimension: "mass",
    unit_name: "short ton",
    multiply_constant: 2000,
    unitary_role: :secondary
  },
  {
    root_dimension: "mass",
    unit_name: "kilogram",
    multiply_constant: 2.20462,
    unitary_role: :secondary
  },
  {
    root_dimension: "mass",
    unit_name: "metric ton",
    multiply_constant: 2204.62,
    unitary_role: :secondary
  }
]

dimensions.each do |dimension|
  CU::Dimension.find_or_create_by! dimension
end