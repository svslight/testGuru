class Admin::TestsController < Admin::BaseController

  # использ.метод обратного вызова, метод current_user вернет тек.польз-ля
  # который залогинен и аутенцифицирован в приложении
  # before_action :authenticate_user!  # переносим в base_controller.rb

  before_action :find_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update destroy start update_inline]
  # before_action :find_user, only: :start

  # GET    /tests
  def index
  end

  # GET  /tests/:id
  def show
    @questions = @test.questions
  end

  # GET  /tests/new
  def new
    @test = Test.new 
  end

  # GET  /tests/:id/edit
  def edit
  end

  # POST /tests
  def create 
    @test = current_user.authored_tests.new(test_params)   # new - создать в памяти

    if @test.save
      # перенаправляем на созданный объект теста
      # redirect_to admin_tests_path, notice: "Добавлен новый тест! Автор: #{@test.author.first_name} #{@test.author.last_name}"
      redirect_to admin_tests_path, notice: t('.success', first_name: @test.author.first_name, last_name: @test.author.last_name )
    else
      render  :new                  # рендерим форму 
    end
  end

  # PATCH  /tests/:id
  def update
    if @test.update(test_params)                              # вызываем метод update, вызываем параметры
      redirect_to admin_tests_path, notice: t('.success')     # перенаправляем на созданный объект
      # redirect_to [:admin, @test]
    else
      render  :edit                                           # рендерим представление new 
    end 
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path, notice: t('.success')
    else
      render :index
    end
  end

  # DELETE /tests/:id
  def destroy
    @test.destroy			                                        # вызываем метод destroy
    redirect_to admin_tests_path, notice: t('.success')       # список всех тестов без уд.записи
  end

  def start
    # @test = Test.find(params[:id])        # найдем тест, который хотим проходить
    # @user.tests.push(@test)               # добавим к user список тестов, которые он проходит с помощ ассоциации test(метод Push)
    
    current_user.tests.push(@test)          # тест привязывается к тек пользователю

    # перенаправ на ресурс(test_passage-описать в модели User), отвечающий за прохождение конкретного теста
    redirect_to current_user.test_passage(@test)
  end

  private 

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :user_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def find_tests
    @tests = Test.all
  end

  # find_user который перед выполнением action#start позволит установить объект пользователя
  # def find_user
  #   @user = User.first  # Берем 1го пользователя из базы (пока нет аутентификации usera) 
  # end 
end
