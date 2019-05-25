Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'about#index', as: 'about'

  post '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/dashboard', to: 'courses#index', as: 'dashboard'
  get '/account', to: 'teachers#show', as: 'account'
  get '/account/edit', to: 'teachers#edit', as: 'edit_teacher'
  patch '/account', to: 'teachers#update'

  get '/password_reset', to: 'password_reset#edit', as: 'password_reset'
  patch '/password_reset', to: 'password_reset#update'

  get '/send_reset_link/new', to: 'send_reset_link#new', as: 'send_reset_link'
  get '/send_reset_link', to: 'send_reset_link#edit', as: 'edit_send_reset_link'
  patch '/send_reset_link', to: 'send_reset_link#update'

  namespace :student do
    root to: redirect('/auth/google_oauth2'), as: 'auth'
    get '/class_code', to: 'class_code#new', as: 'class_code'
    get '/failure', to: 'unregistered#index', as: 'unregistered'
    post '/survey', to: 'survey#create'
    get '/survey', to: 'survey#show'
    get '/survey/complete', to: 'response#show', as: 'completed_survey'
    post '/response', to: 'response#create', as: 'response'
  end
  get '/auth/google_oauth2/callback', to: 'student/survey#new'

  mount ActionCable.server, at: '/cable'
end
