Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  
  get :logged_in, to: 'sessions#logged_in'

  resources :skills, only: [:index, :create, :update]
  resources :measures, only: [:index, :create, :show]

  delete 'skills/destroy/:skill_id', to: 'skills#destroy'
end
