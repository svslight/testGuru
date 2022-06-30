class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  def get_level_tests(level)
    Test.joins(:tests_users).where(tests: {level: level}, tests_users: {user_id: id})
  end
end
