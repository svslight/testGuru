# require 'digest/sha1'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  devise :database_authenticatable, 
        :registerable,
        :recoverable, 
        :rememberable,
        :trackable,
        :validatable,
        :confirmable

  # include Auth

  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :authored_tests, class_name: 'Test', foreign_key: :user_id

  validates :email, presence: true, uniqueness: true

  # has_secure_password

  def get_level_tests(level)
    tests.where(level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end

  # Использ в application_controller.rb
  def admin?
    is_a?(Admin)
  end
end
