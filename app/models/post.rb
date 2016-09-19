class Post < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  has_one :post_info
  has_and_belongs_to_many :tags

  validates :user, presence: true
end
