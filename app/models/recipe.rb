class Recipe < ApplicationRecord

  validates :title, presence: true, length: { maximum: 100 }
  validates :materials_text, presence: true
  validates :steps_text, presence: true
end
