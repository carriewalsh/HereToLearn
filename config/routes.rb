Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'

  post '/login', to: 'session#create', as: login
  get '/logout', to: 'session#destroy', as: logout
end
