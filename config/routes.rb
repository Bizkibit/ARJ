Rails.application.routes.draw do

  resources :organizations, except: []

  resources :users, except: [:destroy]

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

end
