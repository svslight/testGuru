Rails.application.routes.draw do

  root 'tests#index'

  # Для action :new сделаем отд.маршрут: signup
	#	Чтобы в браузере для получения страницы на регистрацию пользователь вводил (...:3000/signup )
	#	Этот url будет вести нас в контроллере-users на action:new
  get :signup, to: 'users#new'

  # Форма будет отображаться с помощ  маршрута login и вести на метод new внутри контроллера sessions
  get :login, to: 'sessions#new'
  delete :logout, to: 'sessions#destroy'

  # Для ресурса users укажем только action :create
  # Для ресурса sessions Rails (по умолчанию) сгенерирует URL-маршруты только для create
  resources :users, only: :create
  resources :sessions, only: :create

  resources :tests do            
    resources :questions, shallow: true, except: :index do
      resources :answers, shallow: true, except: :index
    end

    member do
      post :start
    end
  end

  # GET /test_passages/101/result
  resources :test_passages, only: %i[show update] do 
    member do
      get :result  # показать результат конкретного теста
    end
  end
  
end
