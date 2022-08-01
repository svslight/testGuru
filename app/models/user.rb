class User < ApplicationRecord

  has_many :test_passages
  has_many :tests, through: :test_passages
  # has_many :authored_tests, class_name: 'Test', foreigen_key: :user_id 

  validates :email, presence: true, uniqueness: true

  def get_level_tests(level)
    # Scope-метод
    tests.where(level: level)

    # Метод модели
    # Test.joins(:tests_users).where(tests: {level: level}, tests_users: {user_id: id})
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
