class Novel < ApplicationRecord
  belongs_to :novel_list, touch: true
  belongs_to :user
  has_many :likes, class_name: 'NovelLike', dependent: :destroy

  validates :text, presence: true
  validate :text_length
  #通常のvalidatesで文字制限すると改行を２文字にカウントする為に独自バリデーション

  has_one_attached :image

  validate :validate_image

  def validate_image
    return unless image.attached?
    if image.blob.byte_size > 5.megabytes
      errors.add(:image, I18n.t('ファイルサイズが5Mまでです'))
    elsif !image?
      errors.add(:image, I18n.t('投稿できるファイルは画像のみです'))
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end

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
