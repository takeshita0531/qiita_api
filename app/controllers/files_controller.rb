class FilesController < ApplicationController
   before_action :authenticate_user!
  def new
    @file_name = FileName.new
  end 
  
  def index
    @file = FileName.new
    @file_all = FileName.where(user_id: current_user.id)
    @folders = Folder.where(user_id: current_user.id)
  end
  def show
    @file_new = FileName.new
    # @file = File.find(params[:id])
    @file_all = FileName.where(user_id: current_user.id)
    @folders = Folder.where(user_id: current_user.id)
    folder_id = Folder.new
    file_id = params[:file_id]
    
    folder_id.file_id = file_id
    if file.save
      redirect_fallback(fallback_location: root_path)
      # redirect_to files_path
    end 
  end
  def create
     @file = FileName.new(file_params)
     if @file.save
       redirect_to files_path
     else
       redirect_to files_path
       flash[:notice] = "ファイル名を入力してください"
     end 
  end 
  
  def update
      # file = File.find(params[:id])
      # file.update(file_params)
      folder_id = Folder.new
      file_id = params[:file_id]
      folder_id.file_id = file_id
      if file.save
        # redirect_fallback(fallback_location: root_path)
        redirect_to files_path
      end 
  end 
  
  private
  
  def file_params
    params.require(:file_name).permit(:file_name, :user_id)
  end 
    
end