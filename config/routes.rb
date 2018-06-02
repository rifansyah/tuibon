Rails.application.routes.draw do
  root to: "pics#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pics
  get "pics/:id/download", to: 'pics#download'
end
