class SessionsController < ApplicationController

  # Отвечает за отображение формы
  def new
  end

  # Отвечает за создание пользовтеля сессии

  # Если user = nil, то render :new
  # Чтобы работать с сессиями в Rails сущ-ет метод: session
  # он похож на хэш и позволяет для ключей устанавливать значения	в переменной user
  # user&.authenticate(params[:password]) - у объект (user) вызываем метод authenticate
  # и строим хэш на основе пароля который поль-ль передал в приложение
  # и если пароль совпадет с хэшом в базе в атрибуте password_didgest -	то все ок
  #	И после этого в session под ключом :user_id - (session[:user_id])
  #	сохраним ид-р нашего пользователя (user.id) - session[:user_id] = user.id
  # После того как мы сохранили id польз-ля в сессию - это все записалось в кукку отправилось на клиент
  # клиент сохранил у себя, чтобы передать следующим запросом к нам на сервер
  # мы делаем перенаправление на страничку с тестами

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path     # tests_path  => tests#index
    else
      flash.now[:alert] = 'Введен некорректный электронный адрес или пароль.'
      redirect_to login_path    # render :new => sessions#new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
