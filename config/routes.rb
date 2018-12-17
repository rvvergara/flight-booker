Rails.application.routes.draw do
  get 'bookings/new'
  root "flights#index"
  resources :flights
  resources :bookings
end
