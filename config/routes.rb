Rails.application.routes.draw do
  resources :contact_us
  resources :cards
  resources :services, :cars

  resources :vouchers,  only: [:index, :show, :new, :create]

  resources :ratings, only: :update

  devise_for :businesses, path: 'businesses', controllers: {
    sessions: "businesses/sessions",
    registrations: "businesses/registrations"
  }

  devise_for :customers, path: 'customers', controllers: {
    sessions: "customers/sessions",
    registrations: "customers/registrations"
  }

  resources :businesses do
    resources :schedules, only: [:new, :create]
  end

  get 'index/index'
  post 'index/index', action: :search, controller: 'index'
  get 'index/login'
  get 'index/signup'
  get 'index/about'
  get 'cep/index'
  get 'schedules/business_show'
  get 'schedules/customer_show'
  get 'schedules/destroy/:id', to: 'schedules#destroy'
  get 'reports/top10'
  get 'reports/top10LavaJatos'
  get 'reports/lucro'
  get 'reports/cliente'
  get 'spreadsheets/spreadsheet'
  get 'spreadsheets/spreadsheetLavaJato'
  get 'spreadsheets/spreadsheetLucro'
  get 'spreadsheets/spreadsheetClientes'
  get 'reports/cancelados'




  devise_scope :customer do
    get 'sign_in', to: 'devise/sessions#new'
  end

  root to: "index#index"
end
