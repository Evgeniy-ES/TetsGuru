class Badge < ApplicationRecord
  has_many :user_badges
  has_many :users, through: :user_badges

  validates :name, presence: true
  BACKEND_ID = 2

  def complete_all_tests_backend(user_id)
    tests_backend = []
    tests_user = []
    Test.where(category_id: BACKEND_ID).each {|x| tests_backend.push(x.id)}
    TestPassage.where(user_id: user_id, test_success: true).each {|x| tests_user.push(x.test_id)}
    tests_user = tests_user.uniq
    (tests_backend - tests_user).empty?
 end

 def first_succes_test_complete(user_id, test_id)
   tests_user = []
   TestPassage.where(user_id: user_id, test_id: test_id).each {|x| tests_user.push(x.test_id)}
   tests_user.size == 1
 end

 def completed_level_all_tests(user_id, test_id)
   level_current_test = Test.find(test_id).level
   test_with_level = []
   Test.where(level: level_current_test).each {|x| test_with_level.push(x.id)}
   test_user_with_level = []
   identical_tests = []
   TestPassage.where(user_id: user_id, test_success: true).each do |x|
      if !test_user_with_level.include? x.test_id
        test_user_with_level.push(x.test_id)
      else
        identical_tests.push(x.test_id) if !identical_tests.include? x.test_id
      end
   end

   return false if test_with_level.sort == identical_tests.sort

   test_user_with_level.sort == test_with_level.sort
 end

end
