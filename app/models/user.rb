class User < ApplicationRecord
  has_many :tests_users
  has_many :tests, through: :tests_users

  validates :email, presence: true, uniqueness: true

  def get_level_tests(level)
    # Scope-метод
    tests.where(level: level)

    # Метод модели
    # Test.joins(:tests_users).where(tests: {level: level}, tests_users: {user_id: id})
  end
end
