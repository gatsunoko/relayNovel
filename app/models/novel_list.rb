class NovelList < ApplicationRecord
  has_many :novels, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }

  is_impressionable :counter_cache => true, :column_name => :pv_count, unique: :all
end
