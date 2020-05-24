class NovelList < ApplicationRecord
  #time_select   bool       時間で次の投稿を選ぶかどうか
  #select_time   datetime   次の投稿を選ぶ時間
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

  # def self.timeSelected
  #   novelLists = NovelList.where(time_select: true).where('select_time > ?', Time.now)
  #   #novelLists = NovelList.all
  #   novelLists.each do |novelList|
  #     maximum = novelList.novels.maximum(:number)
  #     if 0 == novelList.novels.where(number: maximum).where(selected: true).count
  #       novel = novelList.novels.where(number: maximum).where(likes_count: novelList.novels.maximum(:likes_count)).first
  #       novel.update(selected: true)
  #     end
  #   end
  # end
end
