class Admin::QuestionsController < Admin::BaseController
    
  # before_action :authenticate_user!
  before_action :find_test, only: [:new, :create]
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  
  # GET     /admin/tests/:test_id/questions
  # Список вопросов теста http://127.0.0.1:3000/admin/tests/6/questions
  #def index
    # @test = Test.find(params[:test_id])
  #end
  
  # GET     /admin/questions/:id
  # Конкретный вопрос теста  http://127.0.0.1:3000/admin/questions/1
  def show
   # @question = Question.find(params[:id])
   @answers = @question.answers
  end

  # GET  /admin/questions/:id/edit
  def edit
  end
  
  # GET    /admin/tests/:test_id/questions/new  /admin/tests/6/questions/new
  # Вызов формы для создания вопроса
  def new
    # @test = Test.find(params[:test_id])
    @question = @test.questions.new
  end
  
  # POST    /admin/tests/:test_id/questions
  # Создать вопрос  http://127.0.0.1:3000/admin/tests/6/questions/new
  def create
    # @test = Test.find(params[:test_id])

    @question = @test.questions.new(question_params)    
  
    if @question.save
      redirect_to admin_question_path(@question), notice: 'Добавлен новый вопрос!'
      # render plain: 'Вопрос успешно создан!'
    else
      render :new
      # render plain: 'Ошибка при создании вопроса!'
    end
  end

  #PATCH   /admin/questions/:id
  def update
    # @test = Test.find(params[:test_id])
    # @question = Question.find(params[:id])

    if @question.update(question_params)
      redirect_to admin_test_path(@question.test), notice: 'Вопрос обновлен!'
    else
      render :edit
    end
  end
  
  # DELETE /admin/questions/:id   http://127.0.0.1:3000/admin/tests/6/questions
  def destroy
    # @question = Question.find(params[:id])

    @question.destroy
    redirect_to admin_test_path(@question.test), notice: 'Вопрос удален!'
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
    render plain: 'Вопрос не найден!'
  end

end
