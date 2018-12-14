Rails.application.routes.draw do
  root "flights#index"
  # get "/flights/", to: "searches#index", as: "searches"
  resources :flights
end
