class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #belongs_to :book
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name , presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction , length: {maximum: 50}

  has_many :books
  #accepts_nested_attributes_for :book
  has_many :post_images, dependent: :destroy
  attachment :profile_image
  attachment :books
end
