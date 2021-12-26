class Admin::BadgesController < Admin::BaseController
  skip_before_action :authenticate_user!, raise: false
  before_action :find_badge, only: %i[ edit update destroy ]

  def index
    @badges = Badge.all
    @rules = Rule.all
  end

  def new
    @badge = Badge.new
  end

  def update
    if @badge_find.update(badge_params)
      redirect_to admin_badges_path
    else
      render :edit
    end
  end

  def destroy
    @badge_find.destroy
    redirect_to admin_badges_path
  end

  def edit

  end

  def create

    @badge = Badge.new(badge_params)

    byebug

    if @badge.save
      redirect_to admin_badges_path, notice: t('.success')
    else
      render :new
    end

  end


  private

  def badge_params
    params.require(:badge).permit(:title, :url_badge, :rule_id, :parametr)
  end

  def find_badge
    @badge_find = Badge.find(params[:id])
  end
end
