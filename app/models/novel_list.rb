class NovelList < ApplicationRecord
  has_many :novels, dependent: :destroy
end
