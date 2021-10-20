Rails.application.routes.draw do

  root to: 'tests#index'


#  get '/tests/:category/:title', to: 'tests#search', level: 1

   resources :tests do
     resources :questions, shallow: true
   end

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
