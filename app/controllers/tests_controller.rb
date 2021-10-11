class TestsController < ApplicationController

  #skip_before_action :find_test, only: :show
  before_action :find_test, only: %i[show]
  after_action :send_log_message
  around_action :log_execute_time

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  def index
    #byebug
    result = ["Class: #{params.class}", "Parameters: #{params.inspect}"]
    render plain: result.join("\n")
  end

  def show
    render inline: '<%= @test.title %>'
  end

  def new

  end

  def create
    test = Test.create(test_params)
    render plain: test.inspect
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

  def find_test
    @test = Test.find(params[:id])
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