class Novel < ApplicationRecord
  belongs_to :novel_list
  belongs_to :user

  validates :text, presence: true
  validate :text_length
  #通常のvalidatesで文字制限すると改行を２文字にカウントする為に独自バリデーション
  def text_length
    content_for_validation = text.gsub(/\r\n/,"a")
    if content_for_validation.length > 200
      errors.add(:text, "は200文字以内で入力してください。")
    end
  end
end
