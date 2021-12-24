class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  has_many :users
  belongs_to :rule

  #before_action :authenticate_user!

  validates :name, presence: true



end
