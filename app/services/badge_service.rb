class BadgeService

  def initialize(current_user)
    @badges = Badge.all
    testpassage = TestPassage.where(user_id: current_user.id).last

    @badges.each do |badge|
      rule_name = str_for_send(badge.rule.name)
      user.badges << badge if send(rule_name, badge, testpassage)
    end
  end

  def passed_all_parametr_tests(badge, testpassage)

    if Category.where(title: badge.parametr)
      tests_backend = Test.where(category_id: Category.where(title: badge.parametr)[0].id).pluck(:id)
      tests_user = TestPassage.where(user_id: testpassage.user_id, test_success: true).pluck(:test_id).uniq
      (tests_backend - tests_user).empty?
    end
  end

  def passed_the_test_on_the_first_attempt(badge, testpassage)
   tests_user = TestPassage.where(user_id: testpassage.user_id, test_id: testpassage.test_id, test_success: true).pluck(:test_id)
   tests_user.size == 1
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

   test_user_with_level.sort == test_with_level.sort
  end




  private

  def str_for_send(str)
    str.tr!(' ', '_')
    str
  end

end
