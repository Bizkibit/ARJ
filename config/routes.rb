Rails.application.routes.draw do

  resources :organizations do
    resources :events
  end

  resources :users, except: [:destroy]

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

end
