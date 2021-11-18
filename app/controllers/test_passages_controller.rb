class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show

  end
  def result
  end
  def update
    @test_passage.accept!(params[:answer_ids])
    #byebug
    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist

    result = GistQuestionService.new(@test_passage.current_question).call

    flash_options = if result.html_url.nil?
      { alert: t('.failure') }
    else
      Gist.create(
        question_id: @test_passage.current_question.id, link_to_gist: result.html_url, user_id: current_user.id)
      byebug
      ans = t('.success') + " " + result.html_url
      { notice: ans }

    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
    #byebug
  end
end
