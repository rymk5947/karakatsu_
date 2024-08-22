class User < ApplicationRecord
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :validatable

has_many :posts, dependent: :destroy

has_many :favorites, dependent: :destroy
has_many :favoried_posts, through: :favorites, source: :post

has_many :post_comments, dependent: :destroy

has_one_attached :profile_image

validates :name, presence: true

def remove_profile_image
self.profile_image.purge # プロファイル画像を削除するメソッド
end

def is_active
  self.is_delete.nil?
end

def already_favorited?(post)
  return false unless post # postオブジェクトが存在しない場合はfalseを返す
  self.favorites.exists?(post_id: post.id)
end

def self.search_for(content, method)
if content.present?
if method == 'partial'
User.where('name LIKE ?', "#{content.to_s}%")
else
User.where('name LIKE ?', "#{content.to_s}%")
end
else
User.none
end
end

# フォローする側から中間テーブルへのアソシエーション
has_many :relationships, foreign_key: :following_id
# フォローする側からフォローされたユーザを取得する
has_many :followings, through: :relationships, source: :follower

# フォローされる側から中間テーブルへのアソシエーション
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
# フォローされる側からフォローしているユーザを取得する
has_many :followers, through: :reverse_of_relationships, source: :following

# あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
def is_followed_by?(user)
  reverse_of_relationships.find_by(following_id: user).present?
end

end