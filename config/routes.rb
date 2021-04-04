Rails.application.routes.draw do
  root 'static_page_partner#index'
  devise_for :drivers, skip: [:session, :password, :registration]
  devise_for :partners, skip: [:session, :password, :registration]
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: :omniauth_callbacks
    devise_for :partners, controllers: { sessions: 'sessions' }

    namespace :partners do
      get "/partners", to: "partners#index"
      devise_scope :partner do
        get "/sign_in", to: "sessions#new"
        post "/sign_in", to: "sessions#create"
      end
    end
    namespace :api, default: {format: :json} do
      namespace :v1 do
        devise_scope :user do
          post "sign_up", to: 'registrations#create'
          post "sign_in", to: 'sessions#create'
          delete "sign_out", to: 'sessions#destroy'
          get "user", to: 'users#show'
          post "passwords/forgot", to: 'passwords#forgot'
          post "passwords/reset", to: 'passwords#reset'
          get "test_method", to: 'users#test_method'
          post "check_email", to: 'registrations#check_email_exits'
          post "check_phone_number", to: 'registrations#check_phone_number_exits'
          delete "/clear_cart", to: 'carts#clear_cart'
          get "/cart", to: 'carts#show'
        end
        resources :users, only: %i(index show update)
        resources :types, only: %i(index show)
        resources :partners, only: %i(index)
        resource :carts, only: %i(create update destroy)
      end
    end

  end
end
