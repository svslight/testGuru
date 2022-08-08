class QuestionsController < ApplicationController
    
  before_action :authenticate_user!
  before_action :find_test, only: [:new, :create]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  
  # GET     /tests/:test_id/questions
  # Список вопросов теста http://127.0.0.1:3000/tests/6/questions
  #def index
    # @test = Test.find(params[:test_id])
  #end
  
  # GET     /questions/:id
  # Конкретный вопрос теста  http://127.0.0.1:3000/questions/1
  def show
   # @question = Question.find(params[:id])
   @answers = @question.answers
  end
  
  # GET    /tests/:test_id/questions/new   /tests/6/questions/new
  # Вызов формы для создания вопроса
  def new
    # @test = Test.find(params[:test_id])
    @question = @test.questions.new
  end

  # GET  /questions/:id/edit
  def edit
  end
  
  # POST    /tests/:test_id/questions
  # Создать вопрос  http://127.0.0.1:3000/tests/6/questions/new
  def create
    # @test = Test.find(params[:test_id])

    @question = @test.questions.new(question_params)    
  
    if @question.save
      redirect_to test_path(@test)
      # render plain: 'Вопрос успешно создан!'
    else
      render :new
      # render plain: 'Ошибка при создании вопроса!'
    end
  end

  #PATCH   /questions/:id
  def update
    # @test = Test.find(params[:test_id])

    # @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to test_path(@question.test)
    else
      render :edit
    end
  end
  
  # DELETE /questions/:id
  # http://127.0.0.1:3000/tests/6/questions
  def destroy
    # @question = Question.find(params[:id])

    @question.destroy

    redirect_to test_path(@question.test)
    # render plain: 'Вопрос успешно удален!'
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:body)
  end

  def rescue_with_question_not_found
    render plain: 'Вопрос не найден'
  end

end
