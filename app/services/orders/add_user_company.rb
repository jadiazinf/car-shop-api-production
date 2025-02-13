class Orders::AddUserCompany
  attr_reader :order, :user_company_id

  def initialize(order_id, user_company_id)
    @order = Order.find(order_id)
    @user_company_id = user_company_id
  end

  def perform
    user_company = UserCompany.find_by(id: user_company_id)

    if order.nil? || user_company.nil?
      return [false, 'Service order or user company not found', nil]
    end

    order.update!(assigned_to: user_company)
    [true, 'User company added to service order successfully', order]
  end
end
