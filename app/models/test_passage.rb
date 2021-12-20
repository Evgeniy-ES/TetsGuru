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
    if percentage_result >= SUCCESS_RATE_PROCENT
      self.current_question_id = Question.last.id
      self.test_success = true
      save!
      check_badge
      return true
    end
  end


  private

  def check_badge
    badge = Badge.new
    add_badge("Passed all backend tests") if badge.complete_all_tests_backend(user.id)
    add_badge("Passed the test on the first attempt") if badge.first_succes_test_complete(user.id, self.test_id)
    add_badge("Passed all tests of the same level") if badge.completed_level_all_tests(user.id, self.test_id)
  end

  def add_badge(name_rule)

    rule = Rule.find_by(name: name_rule)
    badges = Badge.where(rule_id: rule.id)
    badges.each do |x|
      UserBadge.create(user_id: user.id, badge_id: x.id)
    end
  end


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
