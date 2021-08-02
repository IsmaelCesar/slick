Rails.application.routes.draw do

  namespace :presentation do

    namespace :user do
      get 'login', as: :login

      get 'sign_up', as: :sign_up
      post 'sign_up_apply', as: :sign_up_apply

      post 'create'
      post 'update'
      post 'destroy'
    end
  end

  namespace :presentation do
    get 'main/index'
  end

  namespace :messaging do
    get 'contacts/index'
    post 'contacts/create'
  end

  root to: 'presentation/main#index'
  
  # Sessions managing
  post '/login', to: 'sessions#create', as: :login
  patch '/logout', to: 'sessions#destroy', as: :logout

  get 'slick_main/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
