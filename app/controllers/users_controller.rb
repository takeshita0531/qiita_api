class UsersController < ApplicationController
  def new
    @user = User.new
    session[:user_id] = @user.id
  end 
  
  def show
    @user = current_user
  end
  
  def create
    
  end 
  
  def edit
    @user = User.find_by(id: params[:id])
  end 
  
  def update
    @user = User.find_by(id: params[:id])
    @user = User.update(user_params)

    # if @user.save
      redirect_to ("/users/#{current_user.id}")
    # end 
  end 
  
  private
  
  def user_params
    params.require(:user).permit(:name)
  end 
end
