class MyBadgesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    user_badges = UserBadge.where(user_id: current_user.id)
    @badge = []

    user_badges.each do |ub|
      @badge = @badge.push(Badge.find(ub.badge_id))
    end

    @rule = Rule.all
  end
end
