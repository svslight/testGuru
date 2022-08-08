# Проверка существует ли в сессии польз-ля ид-р, 
#  был ли польз-ль залогинен или нет для того чтобы вытащить этого польз-ля из БД
# Это можно реализовать с помощ обратных вызовов

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # Чтобы использовать @current_user кроме контроллера в представлениях, шаблонах, макетах, фрагментах
  # используется метод класса: helper_method
  # добавить для шаблонов - :logged_in?

  helper_method :current_user, :logged_in? 

  private

  # Делаем redirect на страницу с login_path
  # за исключением того случая когда объект текущего польз-ля (current_user) найден 
  # Далее нужно: Правильно применить обратный вызов:	authenticate_user!
  # чтобы защитить определенные действия контроллеров
  # в TestController и добавить обратный вызов: before_action :authenticate_user!
  # И если удалим кукку (сессию) и попытаемся перезагрузить стр-цу, 
  # то снова попадаем на стр login, т.к. работает обратный вызов: 
  #       в сессии id-польз-ля - нет => и тек польз-ля - нет

  def authenticate_user!
    unless current_user
      # flash[:alert] = 'Are you a Guru? Verify your Email and Password please'
      redirect_to login_path, alert: 'Are you a Guru? Verify your Email and Password please'
    end

    cookies[:email] = current_user&.email
  end

  # Поиск польз-ля по id который, нах-ся в session, если id в сессии есть
  # if session[:user_id] - условие нужно, чтобы избежать лишний запрос к БД
  # перемен экз-ра (@current_user ||= ) - при послед вызовах будет содержать в памяти
  # объекта текущего польз-ля, поэтому повторный запрос к базе выпол-ся не будет

  def current_user 
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  # Проверка: сущетствует ли текущий пользователь

  def logged_in?
    current_user.present?
  end

end
