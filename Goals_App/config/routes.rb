Rails.application.routes.draw do
  
  resources :users, only: [:index, :show, :new, :create]

  resource :session, only: [:create, :new, :destroy]
end