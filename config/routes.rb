Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :data
  resources :sensors
  resources :organizations
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'

  get '/updateData/:organization_id/:sensor_id/:value/:unit' => 'data#updateData'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
