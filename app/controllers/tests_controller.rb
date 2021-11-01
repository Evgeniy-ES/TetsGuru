class TestsController < ApplicationController

  #skip_before_action :find_test, only: :show
  #before_action :find_test, only: %i[show]
  #after_action :send_log_message
  #around_action :log_execute_time

  #rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  before_action :set_test, only: %i[show edit update destroy start]
  before_action :set_user, only: :start

  def index
    #byebug
    @tests = Test.all
  end

  def show

  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.new(test_params)

    if @test.save
      redirect_to @test
    else
      render :new
    end

  end

  def edit

  end

  def destroy

    @test.destroy
    redirect_to tests_path
  end

  def update

    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def start
    @user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end


  # def search
  #   result= ["Class: #{params.class}", "Parameters: #{params.inspect}"]
  #
  #   render plain: result.join("\n")
  # end
  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def set_user
    @user = User.first
  end

  def send_log_message
    logger.info("Action [#{action_name}] wasfinished")
  end

  def log_execute_time
    start = Time.now
    yield
    finish = Time.now - start

    logger.info("Execution time: #{finish * 1000}ms")
  end

  def rescue_with_test_not_found
    render plain: 'Tets was not found'
  end
end
