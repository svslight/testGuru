class TestsController < ApplicationController

  before_action :authenticate_user!
  # before_action :find_test, only: %i[ start ]
  
  # GET    /tests
  def index
    @tests = Test.all
  end

  def start
    @test = Test.find(params[:id])
    current_user.tests.push(@test)          # тест привязывается к тек пользователю
    
    # перенаправ на ресурс(test_passage-описать в модели User), 
    # отвечающий за прохождение конкретного теста
    # redirect_to current_user.test_passage(@test), notice: "Начался тест '#{@test.title}'"
    redirect_to current_user.test_passage(@test), notice: t('.begin', title:@test.title )
  end

  # private 

  # if find_test
  #  @test = Test.find(params[:id])
  # end
  
end
