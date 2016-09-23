class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :user, :blog, presence: true
  validates :user_id, uniqueness: { scope: :blog_id,  message: "you have already subscribed on this blog" }
end
