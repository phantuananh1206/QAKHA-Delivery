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
        get "/products/statistics/month", to: 'statistics_products#statistics_by_month'
        get "/products/statistics/quarter", to: 'statistics_products#statistics_by_quarter'
        get "/products/statistics/year", to: 'statistics_products#statistics_by_year'
        get "/products/statistics", to: 'statistics_products#statistics'
        get "/revenue/statistics/month", to: 'statistics_revenue#statistics_by_month'
        get "/revenue/statistics/quarter", to: 'statistics_revenue#statistics_by_quarter'
        get "/revenue/statistics/year", to: 'statistics_revenue#statistics_by_year'
        get "/revenue/statistics", to: 'statistics_revenue#statistics'
        patch "products/status/:id", to: 'products#update_status', as: :product_status
        patch "vouchers/status/:id", to: 'vouchers#update_status', as: :voucher_status
        patch "partners/status/:id", to: 'partners#update_status', as: :partner_status
      end
      resources :categories
      resources :products
      resources :vouchers
      resources :statistics_products, only: :index
      resources :statistics_revenue, only: :index
      resources :orders
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
          post "activated_account", to: 'registrations#activated_user'
          post "activated_account_driver", to: 'registrations#activated_driver'
          post "activated_account_partner", to: 'registrations#activated_partner'
          get "/users/orders_shipping", to: 'users#orders_shipping'
          get "/users/tracking_order", to: 'users#tracking_order'
          get "suggest_partners", to: 'suggest_choice#suggest_partners'
          post "suggest_partners_nearby", to: 'suggest_choice#suggest_partners_nearby'
          get "suggest_products", to: 'suggest_choice#suggest_products'
          get "/partner", to: 'partners#show_partner'
          get "/drivers/order_history", to: 'drivers#order_history'
          get "/drivers/coins", to: 'drivers#coins_driver'
          get "feedbacks/check_feedback_driver", to: "feedbacks#check_feedback_driver"
          patch "/user/change_password", to: "users#change_password"
          patch "/driver/update_profile", to: "drivers#update_profile"
          patch "/driver/change_password", to: "drivers#change_password"
          patch "user/change_email", to: 'users#change_email'
          post "/contact", to: 'contacts#contact'
        end
        resources :users, only: :index
        resources :types, only: %i(index show)
        resources :partners, only: :index
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
      patch "users/status/:id", to: 'users#update_status', as: :user_status
      patch "vouchers/status/:id", to: 'vouchers#update_status', as: :voucher_status
      get "/partners/statistics/month", to: 'statistics_partners#statistics_by_month'
      get "/partners/statistics/quarter", to: 'statistics_partners#statistics_by_quarter'
      get "/partners/statistics/year", to: 'statistics_partners#statistics_by_year'
      get "/partners/statistics", to: 'statistics_partners#statistics'
      get "/drivers/statistics/month", to: 'statistics_drivers#statistics_by_month'
      get "/drivers/statistics/quarter", to: 'statistics_drivers#statistics_by_quarter'
      get "/drivers/statistics/year", to: 'statistics_drivers#statistics_by_year'
      get "/drivers/statistics", to: 'statistics_drivers#statistics'
      get "/products/statistics/month", to: 'statistics_products#statistics_by_month'
      get "/products/statistics/quarter", to: 'statistics_products#statistics_by_quarter'
      get "/products/statistics/year", to: 'statistics_products#statistics_by_year'
      get "/products/statistics", to: 'statistics_products#statistics'
      get "/users/addresses/:id", to: 'users#new_address', as: :new_users_addresses
      post "/users/addresses", to: 'users#create_address'
      get "/users/addresses/:id/edit_address", to: 'users#edit_address', as: :edit_users_addresses
      patch "/users/addresses/:id", to: 'users#update_address'
      delete "/users/addresses/:id", to: 'users#delete_address'
      get "revenue/month", to: 'revenue_report#revenue_by_month'
      get "revenue/year", to: 'revenue_report#revenue_by_year'
      get "revenue", to: 'revenue_report#revenue'
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
      resources :users do
        collection { get :export }
      end
      resources :addresses, except: :show do
        collection { get :export }
      end
      resources :vouchers, except: :show do
        collection { get :export }
      end
      resources :orders, only: %i(index show update) do
        collection { get :export }
      end
      resources :feedbacks, except: :show do
        collection { get :export }
      end
      resources :statistics_partners, only: :index
      resources :statistics_drivers, only: :index
      resources :statistics_products, only: :index
      resources :revenue_report, only: :index
    end
  end
end
