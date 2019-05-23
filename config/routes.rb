Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'about#index', as: 'about'

  get '/student', to: redirect('/auth/google_oauth2')
  get '/auth/google_oauth2/callback', to: 'survey#new'

  get '/student/class_code', to: 'class_code#index', as: 'class_code'
  get '/student/failure', to: 'unregistered#index', as: 'unregistered'
  post '/login', to: 'session#create', as: 'login'
  get '/logout', to: 'session#destroy', as: 'logout'
end
