class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :show]
  
  def show
    @user = current_user
    @folders = @user.folders.order(created_at: :desc)
    @files = @user.file_names
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
  
  private
  
  def user_params
    params.require(:user).permit(:name)
  end 
  
  def correct_user
    user = User.find_by(id: params[:id])
    unless user.id == current_user.id 
      redirect_to root_path, alert: '不正な操作を検知しました。'
    end
  end
end
