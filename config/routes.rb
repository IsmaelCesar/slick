Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

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
    get 'chats/index'
    get 'chats/current_user_chat_ids', to: 'chats#current_user_chat_ids', as: :current_user_chat_ids
    get 'chats/show/:id', to: 'chats#show', as: :show_chats
    post 'chats/send_message/:id', to: 'chats#send_message', as: :send_message
    post 'chats/create', as: :create_contact

    # new_user_invites
    get 'user_invites/new', as: :new_user_invite
    get 'user_invites/list_received', as: :list_received_invites
    get 'user_invites/list_pending', as: :list_pending_invites
    post 'user_invites/create', as: :create_user_invite
    put 'user_invites/accept/:id', to: 'user_invites#accept', as: :accept_invite
    delete 'user_invites/decline/:id', to: 'user_invites#decline', as: :decline_invite

    # Group invites
    get ':group_id/group_invites/new', to: 'group_invites#new', as: :group_invites_new
    post ':group_id/group_invites/create', to: 'group_invites#create', as: :group_invites_create
    put 'group_invites/accept/:id', to: 'group_invites#accept', as: :accept_group_invite
    delete 'group_invites/decline/:id', to: 'group_invites#decline', as: :decline_group_invite

    # Friends
    get 'friends/index'

    get 'groups/new'
    get 'groups/current_user_text_channel_ids', to: 'groups#current_user_text_channel_ids', as: :current_user_text_channel_ids
    get 'groups/edit/:id', to: 'groups#edit', as: :groups_edit
    get 'groups/show/:id', to: 'groups#show', as: :groups_show
    post 'groups/create'
    get 'groups/user_groups'
    get 'groups/available_groups'

    resources :text_channel

    post 'text_channel/:id/send_text_channel_message', to: 'text_channel_messages#send_text_channel_message', as: :send_text_channel_message
  end

  root to: 'presentation/main#index'
  
  # Sessions managing
  post '/login', to: 'sessions#create', as: :login
  patch '/logout', to: 'sessions#destroy', as: :logout

  get 'slick_main/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
