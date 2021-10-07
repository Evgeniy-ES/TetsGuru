Rails.application.routes.draw do

  root to: 'tests#index'
  resources :tests

  get '/tests/:category/:title', to: 'tests#search'

  # resources :tests do
  #   resources :questions
  # end

  # resources :tests do
  #   resourroot to: 'tests#index'ces :questions, shallow: true
  # end

  # resources :tests do
  #   get :beginner, on: :collection
  #
  #   member do
  #     post :start
  #   end
  # end

  get '/tests/:id/start', to: 'tests#start'

  get '/tests/:id/start', to: 'tasks#start'


end
