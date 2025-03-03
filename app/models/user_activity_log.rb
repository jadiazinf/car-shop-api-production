class UserActivityLog < ApplicationRecord
  self.table_name = 'users_activities_logs'

  belongs_to :user, optional: true
end
