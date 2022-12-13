class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
    if @test_passage.success?
      @test_passage.update(passed: true)
      @badges = BadgeService.new(@test_passage).get_badges
      if @badge.present?
        current_user.badges.push(@badges)
        flash[:notice] = t('.badge')
      end
    end
  end

  def update
    redirect_to @test_passage,
    notice: "Требуется ответить, чтобы перейти к следующему вопросу!!!" and return if !params[:answer_ids].present?

    @test_passage.accept!(params[:answer_ids])
    render :show and return if !@test_passage.completed?  
    redirect_to result_test_passage_path(@test_passage), notice: t('.completed')

    # TestsMailer.completed_test(@test_passage).deliver_now

    # if @test_passage.completed?
    #  TestsMailer.completed_test(@test_passage).deliver_now  # deliver_now - отвечает за отправку письма
    #  redirect_to result_test_passage_path(@test_passage), notice: t('.completed')
    # else
    #  render :show
    #end

  end

  def gist
    service = GistQuestionService.new(@test_passage.current_question)
    response = service.call

    gist_url = response.html_url

    if service.status_ok?
      create_gist!(gist_url)      
      flash[:notice] = t('.success', gist_url: gist_url)
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def create_gist!(gist_url)
    current_user.gists.create(question: @test_passage.current_question, gist_url: gist_url)
  end
end
