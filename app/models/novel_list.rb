class NovelList < ApplicationRecord
  has_many :novels, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 100 }

  is_impressionable :counter_cache => true, :column_name => :pv_count, unique: :all

  has_one_attached :thumbnail

  validate :validate_thumbnail

  def validate_thumbnail
    return unless thumbnail.attached?
    if thumbnail.blob.byte_size > 5.megabytes
      errors.add(:thumbnail, I18n.t('ファイルサイズが5Mまでです'))
    elsif !image?
      errors.add(:thumbnail, I18n.t('投稿できるファイルは画像のみです'))
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(thumbnail.blob.content_type)
  end
end
