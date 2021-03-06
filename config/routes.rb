Rails.application.routes.draw do
  delete 'todos', to: 'todos#destroy'
  resources :todos, only: [:index, :create, :update]

  delete 'users', to: 'users#destroy'
  resources :users, only: [:index, :create]
end
