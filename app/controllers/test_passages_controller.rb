class TestPassagesController < ApplicationController
  require "./app/services/result"

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result   
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestsMailer.completed_test(@test_passage).deliver_now  # deliver_now - отвечает за отправку письма
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    question = @test_passage.current_question
    request_to_gist = GistQuestionService.new(question)
    result = request_to_gist.call

    # result = GistQuestionService.new(@test_passage.current_question).call

    # response = Result.new(request_to_gist.client)

    flash_options = if result.success?
      # url = result.html_url
      # current_user.gists.create(question_id: question.id, gist_url: url )
      { notice: t('.success') }
    else
     { alert: t('.failure') }
    end

    #flash_options = if result.success?
    #  { notice: t('.success') }
    #else
    #  { alert: t('.failure') }
    #end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
