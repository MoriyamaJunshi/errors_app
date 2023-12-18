class Error < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }
  validates :message, presence: true, length: { maximum: 1000 }
end
