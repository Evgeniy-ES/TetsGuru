class TestsController < ApplicationController

  #skip_before_action :find_test, only: :show
  #before_action :find_test, only: %i[show]
  #after_action :send_log_message
  #around_action :log_execute_time

  #rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found
  before_action :authenticate_user!
  before_action :set_test, only: %i[start]

  def index
    #byebug
    @tests_all = Test.all
    @tests = []

    @tests_all.each do |element|
      if element.questions.count > 0
        @tests.push(element)
      end
    end
  end


  def start
    current_user.tests.push(@test)
    redirect_to current_user.test_passage(@test)
  end


  # def search
  #   result= ["Class: #{params.class}", "Parameters: #{params.inspect}"]
  #
  #   render plain: result.join("\n")
  # end
  private

  def set_test
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
