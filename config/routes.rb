Rails.application.routes.draw do
  get '/', to: 'welcome#index', as: 'welcome'
end
