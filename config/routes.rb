Rails.application.routes.draw do
  resources :teams
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :users do
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
