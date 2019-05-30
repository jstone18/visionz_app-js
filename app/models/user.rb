class User < ApplicationRecord

  has_many :posts

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable

  before_save { self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
end
