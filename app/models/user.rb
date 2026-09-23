class User < ApplicationRecord
  SAMPLE_EMAIL = "sample-recipes@otorepi.example".freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy

  # ニックネーム必須
  validates :nickname, presence: true

  def sample_account?
    email == SAMPLE_EMAIL
  end
end
