Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => 'users/omniauth_callbacks' }

  resources :users, only: [:show]

  get '/settings/set_locale/:locale', to: 'settings#set_locale', as: :set_locale

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Thredded::Engine => '/forum'
  mount Facebook::Messenger::Server, at: 'bot'

  root to: 'home#show'

end
