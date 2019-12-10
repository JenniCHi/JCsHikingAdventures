Rails.application.routes.draw do
  
  root 'static_pages#home'
  
  root :to => 'site#home'
  
  get '/static_pages/home' => 'static_pages#home'
  
  resources :bookings
  
  devise_for :users do 
    resources :bookings
  end
  
  resources :adventures
  
  get '/gallery', to: 'static_pages#gallery'

  get '/about', to: 'static_pages#about'
  

  get 'cart/index'
  
  get '/cart/:id', to: 'cart#add' 
  
  get '/cart/:id/remove', to: 'cart#remove'
  
  get '/cart/:id/decrease' => 'cart#decrease'
  
  get '/cart/:id/increase' => 'cart#increase'
  
  post '/cart//updateItemDate' => 'cart#updateItemDate'
  
  get '/cancel' => 'cart#cancel'
  
  get '/welcome' => "cart#index", as: :user_root
  
  get '/checkout' => "cart#createBooking"
  
  get '/admin/attempt_authorise' => 'admins#attempt_authorise' 
  
  post '/admin/authorise' => 'admins#authorise' 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
