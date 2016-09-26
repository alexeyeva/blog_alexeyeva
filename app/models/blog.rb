class Blog < ApplicationRecord
  has_many :subscriptions
  has_many :users, through: :subscriptions, dependent: :destroy
  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :title, presence: true

  def owner(user)
    self.user == user ? "You" : self.user.name
  end

end
