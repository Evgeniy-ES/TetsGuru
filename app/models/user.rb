class User < ApplicationRecord
  has_and_belongs_to_many :tests
  has_many :tests_users
  has_many :test, through: :tests_users
  has_many :author_tests, class_name: 'Test', foreign_key: :author_id

  def tests_by_level(level)
    Test.joins('INNER JOIN users_tests ON users_test.test_id = tests.id')
      .where('tests.level = :level', level: level).where(users_tests: { user_id: self.id})
  end
end
