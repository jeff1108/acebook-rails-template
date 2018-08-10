require 'uri'
class User < ApplicationRecord
  after_create :create_profile
  # This is a module, part of ActiveModel library
  # full details here: https://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
  has_secure_password

  # sets up database relationship for one user has many posts
  has_many :posts
  has_many :likes
  has_one :profile

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_length_of :password, :in => 6..10, :on => :create
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, :uniqueness => true, :format => EMAIL_REGEX

  def create_profile
    Profile.create(user_id: self.id, summary: "Sorry this profile has no summary :(")
  end
end
