class Comment < ApplicationRecord
  belongs_to :user  # コメントしたユーザー
  belongs_to :room  # コメントが紐づく記事
  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: "parent_id", dependent: :destroy
  validates :body, presence: true, length: { maximum: 200 } # コメントの必須バリデーション

  has_one_attached :image
end
