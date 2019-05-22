Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
  get '/about', to: 'about#index', as: 'about'

  post '/login', to: 'session#create', as: 'login'
  get '/logout', to: 'session#destroy', as: 'logout'
end
