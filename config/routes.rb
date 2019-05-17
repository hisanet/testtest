Rails.application.routes.draw do
  
  resources :categories
  resources :orders do
  member do
    get 'output'
    get 'calculate'
    post 'calculate'
    get 'mainte_price'
  end
end
  resources :ord_details do
    collection do
      get 'search'
      post 'update_row_order'
    end
  end
  resources :corporations

  resources :products do
  collection do
      get 'search'
      get 'content'
      get 'mainte_price'
    end
  end
  resources :teams
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'users#index'
 
  resources :users do  
    collection do
      get 'search'
      put 'sort'
    end
  end

  
  resources :users do
    post :update_row_order, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
