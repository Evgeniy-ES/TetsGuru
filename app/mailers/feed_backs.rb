class FeedBacksMailer < ApplicationMailer

  def send_feed_back(feed_back)
    @feed_back = {}
    @feed_back[:feed_back] = feed_back
    @feed_back[:email] = User.find(feed_back.user_id).email
    mail to: Admin.all.map(&:email)
  end

end
