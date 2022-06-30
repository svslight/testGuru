class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user, class_name: 'User'
  has_many   :questions, dependent: :destroy
  has_many   :tests_users
  has_many   :users, through: :tests_users

  def self.get_category_tests(name)
    Test.joins(:category).where(categories: {name: name}).order('tests.title DESC').pluck('tests.title')
  end
end
