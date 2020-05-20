class Novel < ApplicationRecord
  belongs_to :novel_list

  validates :text, length: {maximum: 200, message: 'は200文字以内'}
end
