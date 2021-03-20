Rails.application.routes.draw do
  devise_for :users, skip: [:session, :password, :registration], controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: :omniauth_callbacks

    devise_scope :user do
      get "/signup", to: "devise/registrations#new"
      get "/login", to: "devise/sessions#new"
      post "/login", to: "devise/sessions#create"
      delete "/logout", to: "devise/sessions#destroy"
      # get '/users/auth/:provider' => 'omniauth_callbacks#passthru'
      # get "/edit_password", to: "devise/mailer#password_change"
    end
  end
end
