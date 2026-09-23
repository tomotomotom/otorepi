class Recipe < ApplicationRecord
  belongs_to :user

  scope :samples, -> { joins(:user).where(users: { email: User::SAMPLE_EMAIL }) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :materials_text, presence: true
  validates :steps_text, presence: true

  def sample?
    user&.sample_account?
  end
end
