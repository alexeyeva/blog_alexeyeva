class Blog < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy
  belongs_to :user
  has_many :posts

  validates :title, presence: true
end
