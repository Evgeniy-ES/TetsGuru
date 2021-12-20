class MyBadgesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @badge = current_user.badges
    @rule = Rule.all
  end
end
