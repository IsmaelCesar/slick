Rails.application.routes.draw do
  namespace :presentation do
    get 'main/index'
  end
  root to: 'presentation/main#index'
  get 'slick_main/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
