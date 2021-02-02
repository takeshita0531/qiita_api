class FilesController < ApplicationController
  def new
    @file_name = FileName.new
  end 
  
  def index
    @file_name = FileName.new
    # user_id = current_user.id
    @files = FileName.where(user_id: current_user.id)
    @folders = Folder.where(user_id: current_user.id)

    
  end
  def show

  end
  def create
   file = FileName.new(file_params)
   if file.save
     redirect_to files_path
   end 
  end 
  
  private
  
  def file_params
    params.require(:file_name).permit(:file_name, :user_id)
  end 
    
end
