class Post < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :post_comments, dependent: :destroy

  with_options presence: true do
    validates :genre
    validates :message
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%' + content)
    else
      Book.where('title LIKE ?', '%' + content + '%')
    end
  end
end
