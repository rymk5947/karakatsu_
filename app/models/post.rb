class Post < ApplicationRecord
  enum genres: {
    "J-POP": "0",
    "アニソン": "1",
    "K-POP": "2",
    "ボーカロイド": "3",
    "演歌": "4",
    "洋楽": "5",
    "その他": "6"
  }

  has_one_attached :photo

  belongs_to :user
  has_many :favorites, dependent: :destroy

  has_many :post_comments, dependent: :destroy

  with_options presence: true do
    validates :genre
    validates :message
  end

  def self.search_for(content, method)
    if method == "perfect"
      where(message: content)
    elsif method == "forward"
      where("message LIKE ?", "#{content}%")
    elsif method == "backward"
      where("message LIKE ?", "%#{content}")
    else
      where("message LIKE ?", "%#{content}%")
    end
  end
end
