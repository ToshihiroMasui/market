Rails.application.routes.draw do
  
  devise_for :users
  
  root to: 'products#index'
  
    resources :products do
        collection do
            match 'search' => 'products#search', via: [:get, :post]
        end
        member do
            post :like, to: 'products#like'
            get :payment, to: 'products#payment'
            post :pay, to: 'products#pay'
            
        end
    end
    
    resources :users do
        member do
            get :likes, to: 'users#likes'
        end
    end
    
    
   
   
   
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #devise_scope :user do
   # root "devise/sessions#new"
  #end
end
