Rails.application.routes.draw do

  resources :organizations do
    resources :events
    resources :applications, only: [:create, :destroy, :update] do
      patch '/:id', to: 'applications#update', as: :membership
    end
  end

  resources :users, except: [:destroy]

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

end
