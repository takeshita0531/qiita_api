Rails.application.routes.draw do

  # get 'files/index'

  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
  } 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  
  root to: 'folders#top'
  resources :files, only: [:index, :edit, :update, :create]
  delete 'files/:id' => 'files#destroy'
  resources :folders, only: [:index, :top, :create, :update, :destroy]
  # get 'folders/:id/destroy' => 'folders#destroy'

 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
