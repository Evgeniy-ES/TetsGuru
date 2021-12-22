class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  #before_action :authenticate_user!

  validates :name, presence: true


  def passed_all_parametr_tests(badge, testpassage)

    backend_id = {'backend' => 2, 'frontend' => '3'}

    if backend_id[badge.parametr]
      tests_backend = Test.where(category_id: backend_id[badge.parametr]).pluck(:id)
      tests_user = TestPassage.where(user_id: testpassage.user_id, test_success: true).pluck(:test_id).uniq
      add_badge(badge.rule_id, testpassage.user_id) if (tests_backend - tests_user).empty?
    end
  end

 def passed_the_test_on_the_first_attempt(badge, testpassage)
   tests_user = TestPassage.where(user_id: testpassage.user_id, test_id: testpassage.test_id).pluck(:test_id)
   add_badge(badge.rule_id, testpassage.user_id) if tests_user.size == 1
 end

 def passed_all_tests_of_the_parametr_level(badge, testpassage)
   level_current_test = Test.find(testpassage.test_id).level
   test_with_level = Test.where(level: level_current_test).pluck(:id)

   test_user_with_level = []
   identical_tests = []
   TestPassage.where(user_id: testpassage.user_id, test_success: true).each do |x|
      if !test_user_with_level.include? x.test_id
        test_user_with_level.push(x.test_id)
      else
        identical_tests.push(x.test_id) if !identical_tests.include? x.test_id
      end
   end

   return if test_with_level.sort == identical_tests.sort

   add_badge(badge.rule_id, testpassage.user_id) if test_user_with_level.sort == test_with_level.sort
 end

 def self.check_badge

   testpassage = TestPassage.last
   badges = Badge.all

   badges.each do |badge|
     badge.metods_check(badge, testpassage)
   end
 end

 def metods_check(badge, testpassage)
   rule_name = str_for_send(Rule.find(badge.rule_id).name)
   send(rule_name, badge, testpassage)
 end

 def add_badge(rule_id, user_id)

   badges = Badge.where(rule_id: rule_id)

   badges.each do |x|
     UserBadge.create(user_id: user_id, badge_id: x.id)
   end
 end

 private

 def str_for_send(str)
  str.tr!(' ', '_')
  str
 end

end
