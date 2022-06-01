class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :email,
         format: { with: /\A\S+@\S+\.\S+\z/},
         presence: true
         
         mount_uploader :image, ImageUploader
         
  # リレーション
  has_many :products
  # リレーション
  has_many :user_likes
  has_many :products, through: :user_likes
  
  
end
