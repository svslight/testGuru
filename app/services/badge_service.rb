class BadgeService
  
  def initialize(test_passage)
    @test_passage = test_passage
    @user = test_passage.user
  end

  def get_badges
    badges = []
    Badge.all.each do |badge|
      value = badge.rule_value
      case badge.rule_type
      when 'category'
        badges.push(badge) if all_in_category?(value) && value == @test_passage.test.category.name
      when 'attempt'
        badges.push(badge) if first_attempt?(value)
      when 'level'
        badges.push(badge) if all_in_level?(value) && value.to_i == @test_passage.test.level
      end
    end
    badges
  end

  private

  def all_in_category?(category)
    Test.with_questions.by_category(category).count == @user.tests.where('test_passages.passed = ?', true).by_category(category).count
  end

  def first_attempt?(attempts)
    @user.tests.where(id: @test_passage.test_id).count == attempts.to_i
  end

  def all_in_level?(level)
    Test.with_questions.by_level(level.to_i).count == @user.tests.where('test_passages.passed = ?', true).by_level(level.to_i).count
  end
end
