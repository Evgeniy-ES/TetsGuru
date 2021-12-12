Rails.application.routes.draw do

  devise_for :users, path: :gurus, path_names: { sign_in: :login, sign_out: :logout }

  root to: "tests#index"


#  get '/tests/:category/:title', to: 'tests#search', level: 1

   resources :tests, only: :index do
     #resources :questions, shallow: true, except: :index do
       resources :questions, only: :index, shallow: true do
       resources :answers, only: :index, shallow: true#, except: :index
     end

     member do
       post :start
     end
   end

   resources :test_passages, only: %i[show update] do
     member do
       get :result
       post :gist
     end
   end

   namespace :admin do
     resources :gists, only: %i[index]
     resources :tests  do
       patch :update_inline, on: :member

      resources :questions, shallow: true do
        resources :answers, shallow: true
      end
    end
   end

   resources :feed_backs, only: %i[new create]

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

  #get '/tests/:id/start', to: 'tests#start'

  #get '/tests/:id/start', to: 'tasks#start'


end
