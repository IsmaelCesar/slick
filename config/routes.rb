Rails.application.routes.draw do
  namespace :presentation do

    namespace :user do
      get 'login'
      post 'login/apply', to: 'presentation/user#login_apply', as: :login_apply

      get 'sign_up'
      post 'sign_up/apply', to: 'presentation/user#sign_up_apply', as: :sign_up_apply

      post 'create'
      post 'update'
      post 'destroy'
    end
  end
  namespace :presentation do
    get 'main/index'
  end
  root to: 'presentation/main#index'
  get 'slick_main/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
