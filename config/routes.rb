Rails.application.routes.draw do

  root 'tests#index'

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  match '/clean', to: 'tests#clean', via: 'get'
  
  resources :tests, only: :index do            
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
      post :gist   # новый маршрут post Для :gist, чтобы сохранить данный вопрос
    end
  end

  resources :badges, only: %i[index show]

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member
      
      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end

    resources :gists, only: [:index]
    resources :badges
  end  
end
