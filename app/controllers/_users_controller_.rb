class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:new, :create]

  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)

    if @user.save
      redirect_to tests_path  # переход на страницу со списком тестов
    else 
      render :new             # иначе - отображаем форму:new
    end
  end

  private

  # параметры которые передаем в модель от пользователя
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
