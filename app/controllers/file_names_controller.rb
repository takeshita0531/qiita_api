class FileNamesController < ApplicationController

  def index
    @file_new = FileName.new
    user = current_user
    @folders = user.folders.order(created_at: :desc)
    @file_all = user.file_names
    folder_id = params[:folder_id]
    folder = Folder.find_by(id: folder_id)
    file_id = params[:file_id]
    destroy = params[:destroy]
    search = params[:search]
    if search.present?
      @files_search = FileName.search(params[:search])
      @file = @files_search.select { |file|
        if current_user.id == file.user_id
          file
        end
      }
      @file_id = @file.first
      @folder_all = Folder.where(file_id: @file_id)
      # binding.pry
      
    end
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
    @file = FileName.find(params[:id])
  end 
  
  def create
     file = FileName.new(file_params)
     if file.save
       redirect_to file_names_path
     else
       redirect_to file_names_path
       flash[:notice] = "ファイル名を入力してください"
     end 
  end 
  
  def update
    file = FileName.find(params[:id])
    if file.update(file_name: file_params[:file_name])
      redirect_to file_names_path
    else
      flash[:notice] = "保存できませんでした"
      render "edit"
    end 
  end 
  
  def destroy
    file = FileName.find(params[:id])
    if file.delete
      redirect_to file_names_path
    else
      flash[:notice] = "削除できませんでした。"
      render "edit"
    end 
  end 
  
  private
  
  def file_params
    params.require(:file_name).permit(:file_name, :user_id)
  end 
    
end