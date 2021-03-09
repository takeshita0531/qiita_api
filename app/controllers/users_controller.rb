class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @user = User.new
    session[:user_id] = @user.id
  end 
  
  def show
    @user = current_user
    @folders = Folder.where(user_id: current_user.id).order(created_at: :desc)
    @files = FileName.where(user_id: current_user.id)
    folder_id = params[:folder_id]
    folder = Folder.find_by(id: folder_id)
    destroy = params[:destroy]
    file_id = params[:file_id]
    if file_id.present?
      folder.file_id = file_id
      if folder.save
        redirect_back(fallback_location: root_path)
      else
        flash[:notice] = "保存できませんでした"
        redirect_back(fallback_location: root_path)
      end 
    end 
    if folder.present? && destroy.present?
      if folder.delete
        redirect_back(fallback_location: root_path)
      else
        flash[:notice] = "削除できませんでした"
        redirect_back(fallback_location: root_path)
      end 
    end   
  end
  
  # def create
    
  # end 
  
  def edit
    @user = User.find_by(id: params[:id])
  end 
  
  def update
    folder = Folder.new
    user = current_user
    folder = Folder.new
    file_id = params[:file_id]
    folder.file_id = file_id
    folder.save
    if user.update(user_params)
      redirect_to ("/users/#{current_user.id}")
    end 
  end 
  
  # def destroy
  #   folder = Folder.find_id(id: params[:id])
  #   folder.delete
  # end 
  
  private
  
  def user_params
    params.require(:user).permit(:name)
  end 
end
