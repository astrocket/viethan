Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Thredded::Engine => '/forum'

  root to: 'home#show'

end
