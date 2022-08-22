# Preview all emails at http://localhost:3000/rails/mailers/tests
class TestsPreview < ActionMailer::Preview
  def completed_test
    test_passage = TestPassage.new(user: User.first, test: Test.first)

    TestsMailer.completed_test(test_passage)
  end
end
