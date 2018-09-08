Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  # resources :wikis
  # resources :collaborators, only: [:create, :destroy]

  resources :charges, only: [:new, :create]

  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    omniauthCallbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'users/unlocks'
  }
  resources :users, only: [:show]

  devise_scope :user do
    put 'users/registrations/downgrade' => 'users/registrations#downgrade', as: 'downgrade'
    patch 'users/registrations/downgrade' => 'users/registrations#downgrade'
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
