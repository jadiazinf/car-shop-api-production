Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  }, controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }
  # devise_for :users, controllers: { sessions: 'my_application_sessions' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :locations do
        get :location_childrens, on: :member
        put :toggle_active, on: :member
        get ':location_type/location_by_type' => 'locations#location_by_type', on: :collection,
            as: :location_by_type
      end
      resources :users, only: %i[update]
      resources :vehicles do
        collection do
          post :create_vehicle
        end
      end
      resources :brands do
        collection do
          post :create_brand
        end
      end
      resources :models do
        get :show_models_by_brand, on: :member
        collection do
          post :create_model
        end
      end
    end
  end
end
