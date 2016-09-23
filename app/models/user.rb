class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :subscriptions
  has_many :blogs, through: :subscriptions
  has_many :blogs

  validates :email, presence: true
  validates :email, confirmation: true
  validates :email, uniqueness: true
  # validates :email, format: { with: /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/, message: "Only emails allowed" }
  validates :first_name, uniqueness: { scope: :email,  message: "should only one user with name and email" }
  validates_associated :posts
end
