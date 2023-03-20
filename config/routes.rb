Rails.application.routes.draw do
  devise_for :users
  

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "customers#index"
  resources :customers  do
    resources :loans do
      get '/emis' =>'emis#index'
      get :update_all_emis, on: :member
    end
    resources :guarentors
  end

  resources :emis do
    get :pay_emi, on: :member
  end

  resources :guarentors
  
  # Defines the root path route ("/")
  # root "articles#index"
end
