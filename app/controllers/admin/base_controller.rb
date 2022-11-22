class Admin::BaseController < ApplicationController

  # Вызываем шаблон для Admina
  layout 'admin'

  # Мы должны быть уверены что польз-ль существует
  before_action :authenticate_user!

  # Запрос администратора
  before_action :admin_required!

  private

  def admin_required!
    # redirect_to root_path, alert: 'Вы не имеете прав для просмотра этой страницы.' unless current_user.is_a?(Admin)
    redirect_to root_path, alert: 'Вы не имеете прав для просмотра этой страницы.' unless current_user.admin?
  end
end
