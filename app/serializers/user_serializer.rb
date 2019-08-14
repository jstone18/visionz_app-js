class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio, :username

  has_many :posts
  has_many :comments
end
