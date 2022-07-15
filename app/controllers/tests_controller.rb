class TestsController < ApplicationController

  before_action :find_test, only: [:show, :edit, :update, :destroy]

  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    # @questions = @test.questions
  end

  def new 
    @test = Test.new 
  end

  def edit
    @test = Test.find(params[:id])
  end

  def create 
    @test = Test.new(test_params)   # new - создать в памяти

    if @test.save 
      redirect_to @test             # перенаправляем на созданный объект теста
    else
      render  :new                  # рендерим форму 
    end
  end

  def update
    @test = Test.find(params[:id]) # вместо создания - ищем существ тест

    if @test.update(test_params)  # вызываем метод update, вызываем параметры
      redirect_to @test           # перенаправляем на созданный объект
    else
      render  :edit              # рендерим представление new 
    end 
  end

  def destroy
    @test = Test.find(params[:id])  # находим тест для удаления

    @test.destroy			              # вызываем метод destroy
    redirect_to tests_path          # список всех тестов без уд.записи
  end

  private 

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :user_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
