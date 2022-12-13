class TestsController < ApplicationController

  before_action :authenticate_user!
  # before_action :find_test, only: %i[ start ]
  
  # GET    /tests
  def index
    # @tests = Test.all
    @tests = Test.with_category.order("categories.name ASC")
  end

  def start
    @test = Test.find(params[:id])

    current_user.tests.push(@test)          # тест привязывается к тек пользователю
    
    # перенаправ на ресурс(test_passage-описать в модели User), 
    # отвечающий за прохождение конкретного теста      
    redirect_to current_user.test_passage(@test), notice: t('.begin', title:@test.title )
  end

  def clean
    TestPassage.all.each{ |rec| rec.destroy  }
    BadgesUser.all.each{ |rec| rec.destroy  }
  end
  
  # private 

  # if find_test
  #  @test = Test.find(params[:id])
  # end
  
end
