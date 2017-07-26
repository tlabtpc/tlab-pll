Rails.application.routes.draw do
  root "assessments#new"

  resource :file_preview, only: %i[show] if Rails.env.test? || Rails.env.development?

  resource :sessions, only: %i[new create destroy]
  resources :users, only: %i[new create]

  resources :assessments, only: [:new, :create, :show] do
    post :send_email, on: :member
  end

  resources :assessment_nodes, only: :create do
    delete :destroy, on: :collection
  end

  resources :assessment_referrals, only: :index

  resources :cross_checks, only: [] do
    CrossCheck::STEPS.each { |step| get step, on: :collection }

    post :next_step, on: :collection
    get :previous_step, on: :collection
  end

  resources :nodes, only: [:show]
  resources :primary_referrals, only: [:show] do
    post :send_email, on: :member
  end

  namespace :dev do
    get '/' => :index
    get ':action'
  end

  namespace :admin do
    root "primary_referrals#index"
    resources :primary_referrals, except: [:destroy, :new, :create]
    resources :special_referrals, except: [:destroy, :new, :create]
    resources :secondary_referrals, except: [:destroy, :new, :create]
    resources :cross_checks, only: [:show, :index] do
      get :export, on: :member
    end
  end
end
