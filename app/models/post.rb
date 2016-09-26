class Post < ApplicationRecord
  after_commit :create_post_info, on: :create

  belongs_to :user
  belongs_to :blog
  has_one :post_info
  has_and_belongs_to_many :tags
  has_many :comments

  validates :user, presence: true
  validates :blog, presence: true
  validates :title, presence: true

  def owner(user)
    self.user == user ? "You" : self.user.name
  end

  def tag_names
    tags.pluck(:name)
  end

  def new_tags
  end

  def likes
    post_info.likes
  end

  def views
    post_info.views
  end

  def rating
    post_info.rating
  end

  protected

    def create_post_info
      PostInfo.create(post: self)
    end

end
