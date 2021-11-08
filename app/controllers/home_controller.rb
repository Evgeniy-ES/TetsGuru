class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => "reply", :raise => false

end
