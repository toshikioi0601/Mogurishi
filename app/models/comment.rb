class Comment < ApplicationRecord
  belongs_to :divelog
  validates :user_id, presence: true
  validates :divelog_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end
