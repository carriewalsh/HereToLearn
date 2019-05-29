Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'about#index', as: 'about'

  post '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/dashboard', to: 'courses#index', as: 'dashboard'
  get '/account', to: 'teachers#show', as: 'account'
  get '/account/edit', to: 'teachers#edit', as: 'edit_teacher'
  patch '/account', to: 'teachers#update'

  get '/password_reset', to: 'password_resets#edit', as: 'password_reset'
  patch '/password_reset', to: 'password_resets#update'

  get '/send_reset_link', to: 'send_reset_links#new', as: 'send_reset_link'
  post '/send_reset_link', to: 'send_reset_links#create'
  get '/send_reset_link', to: 'send_reset_links#edit', as: 'edit_send_reset_link'
  patch '/send_reset_link', to: 'send_reset_links#update'

  resources :courses, only: :show
  resources :students, only: :show

  resources :strategies, only: [:create, :update] do
    member { patch :deactivate }
  end

  namespace :student do
    root to: redirect('/auth/google_oauth2'), as: 'auth'
    get '/class_code', to: 'class_code#new', as: 'class_code'
    get '/failure', to: 'unregistered#index', as: 'unregistered'
    post '/survey', to: 'class_code#create'
    get '/survey', to: 'survey#show'
    get '/survey/complete', to: 'response#show', as: 'completed_survey'
    post '/response', to: 'response#create', as: 'response'
  end

  namespace :counselor do
    get '/dashboard', to: 'dashboard#index'
  end

  get '/auth/google_oauth2/callback', to: 'student/survey#new'

  namespace :api do
    namespace :v1 do
      put '/attendances', to: 'attendances#update'
    end
  end

  mount ActionCable.server, at: '/cable'

  namespace :api do
    namespace :v1 do
      get '/machinelearning/results', to: 'machine_learning#show'
    end
  end

end
