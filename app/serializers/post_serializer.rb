class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user_id, :updated_at, :image

  belongs_to :user
end
