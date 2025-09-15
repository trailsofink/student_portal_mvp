Rails.application.routes.draw do
  resources :surveys, only: %i[index show]
  resources :responses, only: %i[index show] do
    collection do
      get :import_form
      post :import
      get :export
    end
  end
  resource  :session
  resources :passwords, param: :token
  resources :registrations, only: %i[new create edit]
  resources :dashboard
  resources :registrations, only: %i[new create edit update]
  get 'landing', to: 'landing#index', as: :landing
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
    root "dashboard#index"
end
