class Room < ApplicationRecord
  
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :public, inclusion: { in: [true, false] }

  belongs_to :user
  
  belongs_to :tag

  def self.looks(search, word)
    if search == "perfect_match"
      @room = Room.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @room = Room.where("title LIKE?","%#{word}%")
    else
      @book = Room.all
    end
  end

  has_one_attached :image
  has_many :comments, dependent: :destroy

  def room_comments
    comments
  end

  validates :title, length: { in: 2..30 }, presence: true
  validates :body, length: { in: 5..200 }, presence: true

  belongs_to :user

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/room_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
   image.variant(resize_to_limit: [width, height]).processed
  end

end
