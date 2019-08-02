class Post < ApplicationRecord
  after_commit :create_hash_tags, on: :create

  acts_as_votable
  belongs_to :user

  has_many :comments
  has_many :users, through: :comments

  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags

  validates :title, presence: true, length: { maximum: 25 }
  validates :description, presence: true

  has_attached_file :image, styles: { medium: "800x600#", small: "350x250>" }
  validates :image, presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.recent
    order("posts.updated_at DESC")
  end

  def create_hash_tags
    extract_name_hash_tags.each do |name|
      hash_tags.create(name: name)
    end
  end

  def extract_name_hash_tags
    description.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
  end

  def next
    posts = post_ids_by_updated
    post_index = posts.find_index(id)
    next_post = post_index + 1

    if next_post < posts.length
      posts[next_post]
    else
      id
    end
  end

  def prev
    posts = post_ids_by_updated
    post_index = posts.find_index(id)
    prev_post = post_index - 1

    if prev_post > 0
      posts[prev_post]
    else
      id
    end
  end

  private

  def post_ids_by_updated
    @post_ids ||= Post.order(updated_at: :desc).pluck(:id)
  end

end
