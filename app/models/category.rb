class Category < ApplicationRecord
  has_many :tests, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  default_scope { order(:name) }
end
