class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :bio
  has_many :posts
end
