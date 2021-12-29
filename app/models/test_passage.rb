class TestPassage < ApplicationRecord
  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_update :before_update_next_question

  SUCCESS_RATE_PROCENT = 85

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end
    save!
  end

  def count_questions
    self.test.questions.where("id <= ?", current_question.id).count
  end

  def percentage_result
    100.0 / self.test.questions.count * correct_questions
  end

  def success?
    percentage_result >= SUCCESS_RATE_PROCENT
  end

  def test_completed_and_success?
    self.test_success = true if completed? && self.success?
  end

  def calculation_time(test_passage)

    if remaining_time(test_passage.test.timer, test_passage.created_at) > 0
       remaining_time(test_passage.test.timer, test_passage.created_at)
    end
  end

  def remaining_time(timer, begin_time)
    if timer > (Time.now - begin_time).to_i
      timer - (Time.now - begin_time).to_i
    else
      return 0
    end
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end


  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count
    correct_answers.count == correct_answers.where(id: answer_ids).count &&
    correct_answers_count == answer_ids.count
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def before_update_next_question
    self.current_question = next_question
  end



  def correct_answers
    current_question.answers.correct
  end

end
