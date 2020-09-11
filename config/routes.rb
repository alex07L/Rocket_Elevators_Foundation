Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  


  root to: 'pages#index'

  #devise_for :users
  
  devise_for :users, controllers: {
	registrations: 'users/registrations',
	sessions: 'users/sessions'
  }
  
  post 'pages', to: "pages#create"
  post 'identification', to: "voice#ident"
  post 'profile', to: "voice#profile"
  post 'train', to: "voice#train"
  post 'toText', to: "voice#toText"
  get 'result', to: "voice#show"
  get 'voice', to: "voice#index"
  get 'identification', to: "voice#identification"
  get 'text', to: "voice#text"
  post 'leads', to: "pages#createLead"
  post 'donateToMe', to: "pages#donateToMe"
  get 'thankyou', to: "pages#thankyou"
  get 'fileLeads/:id', to: 'pages#download'
  get 'index', to: 'pages#index.html'
  get 'donate', to: 'pages#donate'
  get 'residential', to: 'pages#residential'
  get 'corporate', to: 'pages#corporate'
  get 'quote', to: 'pages#quote'
  get 'geolocalisation/index'
  get 'intervention', to: 'intervention#intervention'
  get 'customer', to: 'intervention#customer'
  get 'building', to: 'intervention#building'
  get 'battery', to: 'intervention#battery'
  get 'column', to: 'intervention#column'
  get 'new', to: 'pages#new'
  get 'test', to: 'pages#test'
  post 'intervention', to: 'intervention#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
