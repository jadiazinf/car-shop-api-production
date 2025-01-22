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
      resources :users do
        get :user_companies, on: :member
        get :search_by_filters, on: :collection
        get :new_token, on: :member
        get :vehicles, on: :member
      end

      resources :vehicles do
        patch :attach_images, on: :member
        patch :toggle_active, on: :member
      end

      resources :locations do
        get :location_childrens, on: :member
        put :toggle_active, on: :member
        get ':location_type/location_by_type' => 'locations#location_by_type', on: :collection,
            as: :location_by_type
        get :location_parents, on: :member
      end

      resources :users_companies_requests do
        get :show_by_company_id, on: :collection
        get :can_user_make_a_request, on: :collection
      end

      resources :companies do
        get :show_by_company_id, on: :collection
        get :company_charter, on: :member
        get :company_images, on: :member
        get :roles_by_company, on: :member
        patch :set_profile_image, on: :member
        get :search_companies_with_filters, on: :collection
        get :services, on: :member
      end

      resources :services

      resources :categories

      resources :users_companies do
        get :admin, on: :member
        get :company_users, on: :collection
        put :toggle_active, on: :member
        get :validate_user_company, on: :collection
      end

      resources :quotes do
        get :services, on: :member
        get :by_user, on: :collection
      end

      namespace :super_admin do
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
end
