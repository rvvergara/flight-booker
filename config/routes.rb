Rails.application.routes.draw do
  root "flights#index"
  get "/flights/search", to: "searches#index", as: "searches"
  resources :flights
end
