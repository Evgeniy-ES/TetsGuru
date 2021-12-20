class BadgesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false

  def index
    @badge = Badge.all
    @rule = Rule.all
  end
end
