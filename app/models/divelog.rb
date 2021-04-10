class Divelog < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :logs, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 140 }
  validates :popularity,
            :numericality => {
              :only_interger => true,
              :greater_than_or_equal_to => 1,
              :less_than_or_equal_to => 5
            },
            allow_nil: true
  validate  :picture_size

  def feed_comment(divelog_id)
    Comment.where("divelog_id = ?", divelog_id)
  end

  def feed_log(divelog_id)
    Log.where("divelog_id = ?", divelog_id)
  end

  private

    # アップロードされた画像のサイズを制限する
    def picture_size
      if picture.size > 10.megabytes
        errors.add(:picture, "：10MBより大きい画像はアップロードできません。")
      end
    end
end
