Rails.application.routes.draw do
  root "assessments#new"

  resource :file_preview, only: %i[show] if Rails.env.test? || Rails.env.development?

  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create]

  resources :assessments, only: [:new, :create, :show]
  resources :assessment_nodes, only: :create

  resources :nodes, only: [:show]

  namespace :dev do
    get '/' => :index
    get ':action'
  end

  namespace :admin do
    root "primary_referrals#index"
    resources :primary_referrals
    resources :secondary_referrals
    resources :nodes
  end

end
