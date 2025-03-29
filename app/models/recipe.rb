class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients
  accepts_nested_attributes_for :steps

  validates :title, presence: true, length: { maximum: 100 }
  validates :materials_text, presence: true
  validates :steps_text, presence: true
end
