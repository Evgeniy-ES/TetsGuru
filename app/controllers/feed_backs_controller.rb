class FeedBacksController < ApplicationController

  before_action :authenticate_user!

  def new
   @feed_back = FeedBack.new
 end

 def create
   @feed_back = FeedBack.new(feed_back_params)
   @feed_back.user_id = current_user.id

   if @feed_back.save
     FeedBacksMailer.send_feed_back(@feed_back).deliver_now
    # TestsMailer.send_feed_back(@feed_back).deliver_now
     redirect_to root_path, notice: t('.success')
   else
     render :new
   end
 end

 private

 def feed_back_params
   params.require(:feed_back).permit(:text)
 end

end
