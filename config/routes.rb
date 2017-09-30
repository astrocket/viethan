Rails.application.routes.draw do

  resources :messages
  resources :chats
  mount RailsAdmin::Engine => '/astrocket', as: 'rails_admin'
  get 'chat_bot/index'
  get 'chat_bot/initiate'
  get 'chat_bot/tell'

  devise_for :users, controllers: { registrations: 'users/registrations', :omniauth_callbacks => 'users/omniauth_callbacks' }

  resources :users, only: [:show]

  get '/settings/set_locale/:locale', to: 'settings#set_locale', as: :set_locale

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Thredded::Engine => '/forum'
  mount Facebook::Messenger::Server, at: 'bot'

  root to: 'home#index'

end
