class MyBadgesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @badges = current_user.badges
  end
end
