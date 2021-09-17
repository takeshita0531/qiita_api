Rails.application.routes.draw do

  root to: "homes#top"
  get 'homes/contact' => 'homes#contact'
  get 'homes/contact_after' => 'homes#contact_after'
  devise_for :users, :controllers => {
  :registrations => 'users/registrations',
  :sessions => 'users/sessions'
  } 
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  
  resources :file_names, only: [:index, :edit, :update, :create, :destroy]
  delete 'files/:id' => 'files#destroy'
  resources :folders, only: [:index, :top, :create, :update, :destroy]
  resources :method_searches
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
