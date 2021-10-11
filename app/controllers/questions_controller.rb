class QuestionsController < ApplicationController

  before_action :find_test, only: %i[index create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: @test.questions.inspect
  end

  def show
    render plain: @question.inspect
  end

  def create
    quest = @test.questions.new(question_params)

    if quest.save
      render plain: quest.inspect
    else
      render plain: 'The question was not created!'
    end
  end

  def destroy
    @question.destroy
  end

  private

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Questions.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

end
