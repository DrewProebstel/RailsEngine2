Rails.application.routes.draw do
  # all the items for a merchant
  get '/api/v1/merchants/:id/items', to: 'api/v1/merchants_items#index'
  get '/api/v1/items/:id/merchant', to: 'api/v1/items_merchants#index'
  namespace :api do
      namespace :v1 do
          resources :merchants, only: [:index, :show, :create, :update] do
        end
          resources :items, only: [:index, :show, :create, :update] do
        end
      end
    end
  end
