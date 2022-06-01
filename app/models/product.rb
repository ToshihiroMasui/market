class Product < ApplicationRecord
    
    mount_uploader :image1, Image1Uploader
    
    # 投稿が特定のユーザーにいいね！されているかどうかを判定
    def like_from?(user)
         self.user_likes.exists?(user_id: user.id)
    end
    
    validates :name, presence: true
    
    belongs_to :user
    belongs_to :category
    
    has_many :user_likes
    has_many :users, through: :user_likes
end
