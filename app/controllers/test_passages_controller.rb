class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      @test_passage.before_update_test_success
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist

    gist_object = GistQuestionService.new(@test_passage.current_question)
    result = gist_object.call
    flash_options = if gist_object.success?
      current_user.gists.create(
        question_id: @test_passage.current_question.id, link_to_gist: result.html_url)

      { notice: t('.success', url: result.html_url) }
    else
      { alert: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
