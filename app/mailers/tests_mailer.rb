class TestsMailer < ApplicationMailer

  def completed_test(test_passage)
    @user = test_passage.user
    @test = test_passage.test

    mail to: @user.email, subject: 'You just completed the TestGuru test!'
  end

  def send_feed_back(feed_back)
    @feed_back = {}
    @feed_back[:feed_back] = feed_back
    @feed_back[:email] = User.find(feed_back.user_id).email
    mail to: Admin.all.map(&:email)
  end

end
