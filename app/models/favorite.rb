class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :divelog
  validates :user_id, presence: true
  validates :divelog_id, presence: true
  default_scope -> { order(created_at: :desc) }
end
