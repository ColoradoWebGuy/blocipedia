Rails.application.routes.draw do

  devise_for :users

  resources :charges, only: [:new, :create, :destroy]

  get 'downgrade' => 'charges#downgrade'

  resources :wikis do
    resources :collaborators, only: [:index, :create, :destroy]
  end

  root :to => 'wikis#index'
end
