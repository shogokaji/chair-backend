Rails.application.routes.draw do
  get '/health_check', to: 'health_checks#index'

  namespace :api do
    namespace :v1 do
      devise_scope :api_v1_user do
        post 'auth/guest_sign_in', to: 'auth/sessions#guest_sign_in'
        get 'auth/sessions', to: 'auth/sessions#index'
      end

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }

      resources :users, only: %i[index update destroy show] do
        member do
          get :likes
        end
        collection do
          get :get_current_user
          post  :search
          patch :set_up
        end
      end

      resources :diaries, only: %i[index create show destroy update] do
        collection do
          get :relational_diaries
          post :search
          post :sort
        end
        resource :likes, only: %i[create destroy]
        resources :comments, only: %i[index create destroy update]
      end

      resources :relationships, only: %i[create destroy]

      resources :messages, only: %i[show create destroy]

      resources :rooms, only: %i[index show]

      resources :notifications, only: %i[index destroy]

      resources :contacts, only: %i[create]

      get '/comments/:id', to: 'comments#list'
    end
  end
end
