class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post_user, class_name: 'User',foreign_key: 'post_user_id'
  belongs_to :novel_list
end
