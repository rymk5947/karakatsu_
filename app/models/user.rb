class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy

  has_many :likes

  has_many :post_comments, dependent: :destroy

  has_many :active_relationships, class_name: 'Follow', foreign_key: 'user_id'
  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'target_user_id'
  has_many :followings, through: :active_relationships, source: :target_user
  has_many :followers, through: :passive_relationships, source: :user

  has_one_attached :profile_image

  validates :name, presence: true

  def remove_profile_image
    self.profile_image.purge # プロファイル画像を削除するメソッド
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
end