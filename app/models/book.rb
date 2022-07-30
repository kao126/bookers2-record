class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_2day_ago, -> { where(created_at: 2.day.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.day.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.day.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.day.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.day.ago.all_day) } # 6日前

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end


  def self.search_for(search, word)
    if search == "perfect"
      @book = Book.where("title LIKE?", "#{word}" )
    elsif search == "forward"
      @book = Book.where("title LIKE?", "#{word}%" )
    elsif search == "backward"
      @book = Book.where("title LIKE?", "%#{word}" )
    else
      @book = Book.where("title LIKE?", "%#{word}%" )
    end
  end
end
