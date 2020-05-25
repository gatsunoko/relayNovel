class Novel < ApplicationRecord
  belongs_to :novel_list
  belongs_to :user
  has_many :likes, class_name: 'NovelLike', dependent: :destroy

  validates :text, presence: true
  validate :text_length
  #通常のvalidatesで文字制限すると改行を２文字にカウントする為に独自バリデーション
  def text_length
    content_for_validation = text.gsub(/\r\n/,"a")
    if content_for_validation.length > 400
      errors.add(:text, "は400文字以内で入力してください。")
    end
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
