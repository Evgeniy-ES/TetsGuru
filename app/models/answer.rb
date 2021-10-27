class Answer < ApplicationRecord
  ANSWERS_LIMIT = 4

  belongs_to :question

  scope :true_answer, -> {where(correct: true)}

  validate :validate_answers_limit_volume_questions, on: :create

  def validate_answers_limit_volume_questions
    errors.add('Replies must be less than [1..4]') if question.answers.count > ANSWERS_LIMIT || question.answers.count == 0
  end
end
