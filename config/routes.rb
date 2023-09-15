Rails.application.routes.draw do
  resources :categories, except: :showy
  resources :products, path: '/'

end
