
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :users, param: :_username
  resources :tasks

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'


end