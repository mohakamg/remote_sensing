Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :data
  resources :sensors
  resources :organizations
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'home#index'

  get '/updateData/:organization_id/:sensor_id/:value/:unit/:datetime' => 'data#updateData', as: 'sort_data_date' #yyyy-mm-dd hh:mm:ss (String)
  get '/sort_data_date/' => 'data#sort_data_date'
  get '/create_xls/:start_time/:end_time/:sensor' => 'data#create_xls', as: 'create_xls'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
