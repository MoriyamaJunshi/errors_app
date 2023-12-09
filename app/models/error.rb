class Error < ApplicationRecord
  validates :content, presence: true, length: { maximum: 255 }
  validates :message, presence: true, length: { maximum: 1000 }
end
