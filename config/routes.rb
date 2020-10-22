Rails.application.routes.draw do

  resources :users
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
  } 
  
  root to: 'folders#top'
  resources :folders, only: [:index, :show, :top]
  # get 'folders/index' => 'folders#index'

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
