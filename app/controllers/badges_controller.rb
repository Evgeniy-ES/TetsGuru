class BadgesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @badges = Badge.all
    @rules = Rule.all
  end
end
