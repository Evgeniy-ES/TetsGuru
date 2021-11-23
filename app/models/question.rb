class Question < ApplicationRecord
  belongs_to :test
  has_many :gists
  has_many :answers, dependent: :destroy
  has_many :current_question, class_name: 'TestPassage', foreign_key: :current_question, dependent: :destroy

  validates :body, presence: true
end
