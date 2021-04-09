class Log < ApplicationRecord
  belongs_to :divelog
  default_scope -> { order(created_at: :desc) }
  validates :divelog_id, presence: true
end
