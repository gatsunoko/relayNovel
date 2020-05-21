class NovelList < ApplicationRecord
  has_many :novels, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
end
