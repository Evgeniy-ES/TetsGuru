class QuestionsController < ApplicationController

  before_action :find_question, only: %i[show]
  before_action :find_test, only: %i[index]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @questions = @test.questions
  end

  #def edit

  #end


  private

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def questions_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    #byebug
    render plain: 'Question was not found'
  end
end
