class Step < ApplicationRecord
  belongs_to :recipe

  validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :content, presence: true
end
