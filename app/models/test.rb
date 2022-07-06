class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user, class_name: 'User'
  has_many   :questions, dependent: :destroy
  has_many   :tests_users
  has_many   :users, through: :tests_users

  # default_scope { order(created_at: :desc) } 

  # Может существовать только один Тест с данным названием и уровнем
  # Наличие атрибута title
  validates :title, presence: true, uniqueness: { scope: :level }

  # Уровень Теста может быть только положительным целым числом
  validates :level, numericality: { only_integer: true }

  # Выбор Тестов по уровню сложности:
  scope :easy, -> { where(level: 0..1).order(level: :asc) }
  scope :mid, -> { where(level: 2..4).order(level: :asc) }
  scope :hard, -> { where(level: 5..Float::INFINITY).order(level: :asc) }

  # Получение Категорий,
  # отсортированных по названию (tests.title desc) в порядке возрастания
  scope :get_category_tests, ->(name) { joins(:category).where(categories: {name: name}) }

  def self.order_by(name)
    get_category_tests(name).order(title: :desc).pluck(:title)
  end

  # def self.get_category_tests(name)
  #   Test.joins(:category).where(categories: {name: name}).order('tests.title DESC').pluck('tests.title')
  # end
end
