class Users::FilterService
  attr_accessor :email, :name, :dni

  def initialize(params)
    @email = params[:email]
    @name = params[:name]
    @dni = params[:dni]
  end

  def perform
    users = User.where(is_active: true)

    if name.present?
      users = users.where("(LOWER(first_name) || ' ' || LOWER(last_name)) LIKE ?",
                          "%#{name.downcase}%")
    end

    users = users.where('LOWER(email) LIKE ?', "%#{email.downcase}%") if email.present?
    users = users.where('dni LIKE ?', "%#{dni}%") if dni.present?
    users
  end
end
