class Blog < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions
  belongs_to :user
  has_many :posts

  validates :title, presence: true
end
