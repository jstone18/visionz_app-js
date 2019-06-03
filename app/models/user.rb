class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :validatable

  before_save { self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_attached_file :image, styles: { medium: "700x500#", small: "350x250>", thumb: "200x200>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 50 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.name = auth.info.name
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end
end
