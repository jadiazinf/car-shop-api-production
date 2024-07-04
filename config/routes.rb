Rails.application.routes.draw do
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
    end
  end
end
