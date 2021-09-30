class User < ApplicationRecord
  has_and_belongs_to_many :tests
  has_many :tests_users
  has_many :test, through: :tests_users
  has_many :author_tests, class_name: 'Test', foreign_key: :author_id

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def tests_by_level(level)
    tests.where(level: level)
  end
end
