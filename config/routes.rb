Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'about#index', as: 'about'

  post '/login', to: 'sessions#create', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/dashboard', to: 'teachers#show', as: 'dashboard'
  get '/account', to: 'account#show', as: 'account'
  get '/account/edit', to: 'teachers#edit', as: 'edit_teacher'
  patch '/account', to: 'teachers#update'

  namespace :student do
    root to: redirect('/auth/google_oauth2'), as: 'auth'
  end
  get '/auth/google_oauth2/callback', to: 'survey#new'
end
