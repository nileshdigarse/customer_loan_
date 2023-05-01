Rails.application.routes.draw do
  devise_for :users
  

  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "loans#index"
  get '/fetch_guarentor' =>'loans#fetch_guarentor'
  resources :customers  do
    resources :loans do
      get '/emis' =>'emis#index'
      get :update_all_emis, on: :member
    end
  end

  resources :emis do
    get :pay_emi, on: :member
  end

  resources :investors do
    member do
      get 'show_by_debit'
    end
    resources :investor_transactions
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
