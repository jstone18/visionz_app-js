class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio

  has_many :posts
  has_many :comments
end
