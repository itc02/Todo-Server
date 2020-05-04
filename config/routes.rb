Rails.application.routes.draw do
  delete 'todos', to: 'todos#destroy'
  resources :todos, only: [:index, :create, :update] do
    collection do
      delete :delete_all, to: 'todos#delete_all'
    end
  end
  delete 'users', to: 'users#destroy'
  resources :users, only: [:index, :create] do
    collection do
      get :all, to: 'users#get_all_users'
    end
  end
end