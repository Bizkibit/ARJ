Rails.application.routes.draw do

  root 'welcome#index'

  resources :organizations do
    resources :events, except: [:index]
    resources :applications, only: [:create, :destroy, :update] do
      patch '/:id', to: 'applications#update', as: :membership
    end
    resources :reviews, only: [:create, :destroy]
  end

  resources :events, only: [] do
    resources :attendances, only: [:create, :destroy]
  end

  resources :users, except: [:destroy]

  resources :sessions, only: [:create, :new] do
    delete :destroy, on: :collection
  end

  # Api backend routes:

  namespace :api , defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:show, :index]
      resources :organizations, only: [:show, :index]
    end
  end

  namespace :admin do
    resources :organizations,  only: [:index, :update]
  end
end
