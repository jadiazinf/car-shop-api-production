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
        get :all_vehicles, on: :collection
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
        get :services_by_vehicle_type, on: :member
        get :employees_by_role, on: :member
        get :company_employees, on: :member
      end

      resources :services

      resources :categories

      resources :orders do
        post :create_order_by_quote, on: :collection
        get :user_orders, on: :collection
        get :user_quotes, on: :collection
        get :company_orders, on: :collection
        get :company_quotes, on: :collection
        get :by_assigned_to, on: :collection
        patch :add_user_company, on: :member
      end

      resources :services_orders do
        post :create_in_batch, on: :collection
        patch :update_services_orders_status, on: :collection
      end

      resources :advances do
        post :attach_image, on: :member
        get :service_order_advances, on: :collection
      end

      resources :users_companies do
        get :admin, on: :member
        get :company_users, on: :collection
        put :toggle_active, on: :member
        get :validate_user_company, on: :collection
        get :user_company_by_user_and_company, on: :collection
      end

      resources :quotes do
        get :services, on: :member
        get :by_user, on: :collection
        patch :close_quotes, on: :member
      end

      resources :user_order_reviews do
        get :company_reviews, on: :collection
        get :user_reviews, on: :collection
        get :company_claims, on: :collection
        get :by_order, on: :collection
        get :company_ratings, on: :collection
      end

      resources :reports do
        get :orders_with_claims, on: :collection
        get :orders_without_claims, on: :collection
        get :claims_by_service_category, on: :collection
        get :claims_by_period, on: :collection
        get :customers_served_by_period, on: :collection
        get :captured_customers_percentage_by_period, on: :collection
        get :captured_customers_by_service_category_and_period, on: :collection
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
