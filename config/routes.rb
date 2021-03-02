Rails.application.routes.draw do

  # get 'files/index'

  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'   
  } 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show, :edit, :update]
  
  root to: 'folders#top'
  resources :folders, only: [:index, :top, :update]
  get 'folders/:id/destroy' => 'folders#destroy'

  resources :files, only: [:index, :show, :create]
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
