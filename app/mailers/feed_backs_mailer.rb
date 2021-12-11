class FeedBacksMailer < ApplicationMailer

  def send_feed_back(feed_back)
    @feed_back = feed_back
    @email = feed_back.user.email
    mail to: Admin.all.map(&:email)
  end

end
