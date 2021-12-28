class Badge < ApplicationRecord
  has_many :users, through: :user_badges
  has_many :users
  belongs_to :rule

  validates :title, presence: true
end
