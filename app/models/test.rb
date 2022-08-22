class Test < ApplicationRecord

  belongs_to :category, optional: true

  # belongs_to :user, class_name: 'User'  
  belongs_to :author, class_name: 'User', foreign_key: :user_id #, optional: true
  
  has_many   :questions, dependent: :destroy

  has_many :test_passages
  has_many :users, through: :test_passages

  # default_scope { order(created_at: :desc) } 

  validates :title, presence: true, uniqueness: { scope: :level }
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
