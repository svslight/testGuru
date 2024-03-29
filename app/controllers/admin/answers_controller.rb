class Admin::AnswersController < Admin::BaseController

  # before_action :authenticate_user!
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only: %i[ show edit update destroy ]

  # Удалить - список ответов будет выводится на стр. вопросов
  # GET /answers or /answers.json
  # def index
  #  @answers = Answer.all
  #end

  # GET
  def show
  end

  # GET 
  def new
    @answer = @question.answers.new
  end

  # GET 
  def edit
  end

  # POST 
  def create
    #@answer = Answer.new(answer_params)
    @answer = @question.answers.new(answer_params)

    if @answer.save
      redirect_to admin_question_path(@answer.question), notice: 'Добавлен новый ответ!'
    else
      render :new
    end
  end

  # PATCH/PUT 
  def update
    if @answer.update(answer_params)
      redirect_to admin_question_path(@answer.question), notice: 'Ответ обновлен!'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to admin_question_path(@answer.question), notice: 'Ответ удален!'
  end

  private

    #
    def find_question
      @question = Question.find(params[:question_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def find_answer
      @answer = Answer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def answer_params
      params.require(:answer).permit(:body, :correct)
    end
end
