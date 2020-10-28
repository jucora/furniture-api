Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :sessions, only: [:create]
  resources :registrations, only: [:index, :create]
  
  get :logged_in, to: 'sessions#logged_in'

  resources :employees, only: [:index, :create, :update]
  resources :customers, only: [:index, :create, :update]

  delete 'skills/destroy/:skill_id', to: 'skills#destroy'
end
