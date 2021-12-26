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
      tests_user = Test.where(category_id: Category.where(title: badge.parametr)[0].id).joins("JOIN test_passages ON test_passages.user_id = #{testpassage.user_id} AND test_passages.test_success = true").pluck(:test_id)

      tests_backend == tests_user
    end
  end

  def passed_the_test_on_the_first_attempt(badge, testpassage)
   tests_user = TestPassage.where(user_id: testpassage.user_id, test_id: testpassage.test_id).pluck(:test_id, :test_success)
   tests_user.size == 1 && tests_user[0][1] == true
  end

  def passed_all_tests_of_the_parametr_level(badge, testpassage)
    level_current_test = Test.find(testpassage.test_id).level
    test_with_need_level = Test.where(level: level_current_test).pluck(:id)
    test_user_with_need_level = Test.where(level: level_current_test).joins("JOIN test_passages ON test_passages.user_id = #{testpassage.user_id} AND test_passages.test_success = true").pluck(:test_id)
    
    test_with_need_level == test_user_with_need_level
  end

  private

  def str_for_send(str)
    str.tr!(' ', '_')
    str
  end

end
