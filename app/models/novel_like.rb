class NovelLike < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  counter_culture :novel, column_name: "likes_count"
end
