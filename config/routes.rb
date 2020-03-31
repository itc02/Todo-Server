Rails.application.routes.draw do
  resources :todos, only: [:index, :create, :update, :destroy] do
    collection do
      delete :delete_all, to: 'todos#delete_all'
      get :get_owners, to: 'todos#get_owners'
    end
  end
  resources :users, only: [:index, :create, :destroy]
  resources :states, only: :index
end