Rails.application.routes.draw do
  delete 'todos', to: 'todos#destroy'
  resources :todos, only: [:index, :create, :update, :destroy] do
    collection do
      delete :delete_all, to: 'todos#delete_all'
      get :get_owners, to: 'todos#get_owners'
    end
  end
  delete 'users', to: 'users#destroy'
  resources :users, only: [:index, :create]
end