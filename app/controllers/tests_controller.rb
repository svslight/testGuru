class TestsController < ApplicationController

  before_action :find_test, only: [:show, :edit, :update, :destroy]

  # GET    /tests
  def index
    @tests = Test.all
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
    @test = Test.new(test_params)   # new - создать в памяти

    if @test.save 
      redirect_to @test             # перенаправляем на созданный объект теста
    else
      render  :new                  # рендерим форму 
    end
  end

  # PATCH  /tests/:id
  def update
    if @test.update(test_params)  # вызываем метод update, вызываем параметры
      redirect_to @test           # перенаправляем на созданный объект
    else
      render  :edit              # рендерим представление new 
    end 
  end

  # DELETE /tests/:id
  def destroy
    @test.destroy			              # вызываем метод destroy
    redirect_to tests_path          # список всех тестов без уд.записи
  end

  private 

  def find_test
    @test = Test.find(params[:id])
  end
  
  def test_params
    params.require(:test).permit(:title, :level, :category_id, :user_id)
  end
end
