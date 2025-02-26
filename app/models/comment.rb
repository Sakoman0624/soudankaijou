class Comment < ApplicationRecord
  belongs_to :user  # コメントしたユーザー
  belongs_to :room  # コメントが紐づく記事

  validates :body, presence: true, length: { maximum: 200 } # コメントの必須バリデーション

  has_one_attached :image
end
