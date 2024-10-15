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

  has_many :photos, dependent: :destroy
  accepts_nested_attributes_for :photos, allow_destroy: true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :post_comments, dependent: :destroy

  validates :message, presence: true

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


  # フォローする側から中間テーブルへのアソシエーション
  #has_many :relationships, foreign_key: :following_id
  # フォローする側からフォローされたユーザを取得する
  #has_many :followings, through: :relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  #has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  # フォローされる側からフォローしているユーザを取得する
  #has_many :followers, through: :reverse_of_relationships, source: :following

  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  #def is_followed_by?(user)
    #reverse_of_relationships.find_by(following_id: user.id).present?
  #end
end
