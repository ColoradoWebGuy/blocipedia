Rails.application.routes.draw do

  devise_for :users

  resources :charges, only: [:new, :create, :destroy] 

  get 'downgrade' => 'charges#downgrade'

  resources :wikis

  root :to => 'wikis#index'
end
