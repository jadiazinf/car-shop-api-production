users = User.pluck(:id)
companies = Company.pluck(:id)

all_possible_relations = users.product(companies).shuffle
selected_relations = all_possible_relations.take(1000)
UserCompany.create!(selected_relations.map do |user_id, company_id|
  {
    user_id: user_id,
    company_id: company_id,
    roles: ["admin", "general"],
    is_active: true
  }
end)
