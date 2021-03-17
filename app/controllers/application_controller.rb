class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user
  # before_action :authenticate_user!

  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    @user = User.find_by(id: params[:id])
  end
  
  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :username, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource) 
    folders_path
  end
  
  def after_sign_out_path_for(resource_or_scope)
      new_user_session_path
  end
end
