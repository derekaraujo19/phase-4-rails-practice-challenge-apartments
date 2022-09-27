Rails.application.routes.draw do
  resources :tenants
  resources :leases, only: [:create, :destroy]
  resources :apartments

end
