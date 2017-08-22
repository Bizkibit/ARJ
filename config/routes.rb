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

  # get('admin/organizations', {to: 'admin/organizations#index', as: :admin_panel})
  # patch('/admin/organizations/:organization_id/', {to: 'admin/organizations#update', as: :cunt})

  # Api backend routs:

  namespace :api , defaults: {format: :json} do
    namespace :v1 do
      resources :users, only: [:show]
    end
  end

  namespace :admin do
    resources :organizations,  only: [:index, :update]
  end
end
