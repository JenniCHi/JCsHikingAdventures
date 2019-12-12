Rails.application.routes.draw do
  
  root 'static_pages#home'
  root :to => 'site#home'
  
  get '/static_pages/home' => 'static_pages#home'
  
  resources :bookings
  resources :adventures
  devise_for :users do 
    resources :bookings
  end
  
  get '/gallery', to: 'static_pages#gallery'

  get '/about', to: 'static_pages#about'
  
  get 'cart/index'
  get '/cart/:id', to: 'cart#add' 
  get '/cart/:id/remove', to: 'cart#remove'
  get '/cart/:id/decrease' => 'cart#decrease'
  get '/cart/:id/increase' => 'cart#increase'
  put '/cart/updateItemDate' => 'cart#updateItemDate'
  put '/updateItemDate' => 'cart#updateItemDate'
  get '/cancel' => 'cart#cancel'
  get '/welcome' => "cart#index", as: :user_root
  get '/checkout' => "cart#createBooking"
  
  get '/admins/attempt_authorise' => 'admins#attempt_authorise' 
  get '/admins/authorise' => 'admins#authorise' 

end
