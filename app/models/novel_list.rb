class NovelList < ApplicationRecord
  has_many :novels, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }
end
