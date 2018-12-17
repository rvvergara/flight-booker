Rails.application.routes.draw do
  get 'bookings/new'
  root "flights#index"
  resources :flights
  resources :bookings, except: :index do
    resources :passengers, only: [:new, :create, :destroy]
  end
end
