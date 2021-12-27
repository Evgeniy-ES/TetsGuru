class BadgeService

  def initialize(current_user)
    @badges = Badge.all
    testpassage = TestPassage.where(user_id: current_user.id).last

    @badges.each do |badge|
      rule_name = str_for_send(badge.rule.name)
      current_user.badges << badge if send(rule_name, badge, testpassage)
    end
  end

  def passed_all_parametr_tests(badge, testpassage)

    if badge.value
      tests_backend = Test.by_category_name(badge.value).pluck('tests.id')
      tests_user = Test.by_category_name(badge.value).joins("JOIN test_passages ON test_passages.user_id = #{testpassage.user_id} AND test_passages.test_success = true").pluck(:test_id)

      tests_backend == tests_user
    end
  end

  def passed_the_test_on_the_first_attempt(badge, testpassage)
    TestPassage.where(user_id: testpassage.user_id, test_id: testpassage.test_id).count ==1 && testpassage.success?
  end

  def passed_all_tests_of_the_parametr_level(badge, testpassage)
    if badge.value.to_i > 0
      test_with_need_level = Test.where(level: badge.value).pluck(:id)
      test_user_with_need_level = Test.where(level: badge.value).joins("JOIN test_passages ON test_passages.user_id = #{testpassage.user_id} AND test_passages.test_success = true").pluck(:test_id)
    end
    test_with_need_level == test_user_with_need_level
  end

  private

  def str_for_send(str)
    str.tr!(' ', '_')
    str
  end

end
