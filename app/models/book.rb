class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  validates :tag,presence:true
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      Book.where(name: word)
    elsif search == "forward_match"
      Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      Book.where("title LIKE?", "%#{word}")
    else
      Book.where("title LIKE?", "%#{word}%")
    end
  end
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
  
end
