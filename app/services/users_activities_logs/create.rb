class UsersActivitiesLogs::Create
  attr_accessor :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def perform
    activity = UserActivityLog.new(user:, event:, user_category: user_category_value)
    activity.save
  end

  private

  def user_category_value
    return 'visitor' if user.nil?

    return 'general' if user.companies.blank?

    'company'
  end
end
