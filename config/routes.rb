Rails.application.routes.draw do
  devise_for :drivers, skip: [:session, :password, :registration]
  devise_for :partners, skip: [:session, :password, :registration]
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root 'static_page_partner#index'
    devise_for :users, skip: :omniauth_callbacks
    devise_for :partners, controllers: { sessions: 'sessions' }

    namespace :partners do
      get "/partners", to: "partners#index"
      devise_scope :partner do
        get "/sign_in", to: "sessions#new"
        post "/sign_in", to: "sessions#create"
      end
      resources :categories
      resources :products
      resources :vouchers
    end

    namespace :api, default: {format: :json} do
      namespace :v1 do
        devise_scope :user do
          post "sign_up", to: 'registrations#create'
          post "sign_in", to: 'sessions#create'
          delete "sign_out", to: 'sessions#destroy'
          post "sign_in_driver", to: 'sessions#sign_in_driver'
          post "passwords/forgot", to: 'passwords#forgot'
          post "passwords/reset", to: 'passwords#reset'
          post "check_email", to: 'registrations#check_email_exits'
          post "check_phone_number", to: 'registrations#check_phone_number_exits'
          delete "/clear_cart", to: 'carts#clear_cart'
          get "/cart", to: 'carts#show'
          get "/orders/list_vouchers", to: 'orders#list_vouchers'
          get "/orders/voucher", to: 'orders#vouchers_by_partner'
          get "/orders/vouchers", to: 'orders#vouchers_by_partner'
          post "/orders/voucher", to: 'orders#apply_voucher'
          delete "/orders/voucher", to: 'orders#cancel_voucher'
          post "/orders/calc_distance", to: 'orders#location'
          post "check_id_card_driver", to: 'registrations#check_id_card_driver'
          post "check_license_plate_driver", to: 'registrations#check_license_plate_driver'
          get "feedbacks/partner", to: 'feedbacks#fb_partner'
          get "feedbacks/driver", to: 'feedbacks#fb_driver'
          get "/orders/coins_user", to: 'orders#coins_user'
          get "/drivers/status_driver", to: 'drivers#status_driver'
          get "/drivers/show_infor", to: 'drivers#show_infor'
          patch "/drivers/complete_delivery", to: 'drivers#complete_delivery'
          post "/orders/feedbacks", to: 'feedbacks#create'
          get "user", to: 'users#show'
          patch "user", to: 'users#update'
          get "/drivers/statistics/day", to: 'statistics_driver#statistics_by_day'
          get "/drivers/statistics/month", to: 'statistics_driver#statistics_by_month'
          get "/drivers/statistics/year", to: 'statistics_driver#statistics_by_year'
        end
        resources :users, only: :index
        resources :types, only: %i(index show)
        resources :partners, only: %i(index)
        resource :carts, only: %i(create update destroy)
        resources :orders, only: %i(create index)
        resources :addresses, only: %i(index create update destroy)
        resources :order_details, only: %i(index)
        resources :drivers, only: %i(index update)
      end
    end

    namespace :admin do
      root "base#home"
      get "sign_in", to: 'sessions#new'
      post "sign_in", to: 'sessions#create'
      delete "logout", to: 'sessions#destroy'
      patch "drivers/status/:id", to: 'drivers#update_status', as: :driver_status
      patch "partners/status/:id", to: 'partners#update_status', as: :partner_status
      patch "products/status/:id", to: 'products#update_status', as: :product_status
      resources :drivers, except: :show do
        collection { get :export }
      end
      resources :partners, except: :show do
        collection { get :export }
      end
      resources :cities, except: :show do
        collection { get :export }
      end
      resources :types, except: :show do
        collection { get :export }
      end
      resources :categories, except: :show do
        collection { get :export }
      end
      resources :products, except: :show do
        collection { get :export }
      end
    end
  end
end
