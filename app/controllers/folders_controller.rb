class FoldersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  
  def new
    @folder = Folder.new
  end 
  
  def top
  end 
  
  def index
    @qiita_api = Api::QiitaApi.new
    @qiita_api.qiita_api
    QiitaMemoryJob.delay(run_at: 1.minutes).perform_later
    @folder_new = Folder.new
    @folders = QiitaMemory.search(params[:search])
    
    @folder_user = []
    folders =  current_user.folders
    folders.each do |folder| 
      @folder_user.push(folder.url)
    end
  end
  
  def create
      folder = Folder.new
      folder.user_id = current_user.id
      folder.article_id = params[:article_id]
      folder.title = params[:title]
      folder.url = params[:url]
      folder.user_name = params[:user_name]
      respond_to do |format|
      if folder.save
        format.html  {redirect_back(fallback_location: true)}
        format.js
      else
        format.html { render :index } 
        format.js { render :errors } 
      end
      end
  end 
  
  def update
      folder = Folder.find(params[:id])
      file_id = params[:file_id]
      folder.file_id = file_id
      if folder.save
        redirect_back(fallback_location: root_path)
      else
        flash[:notice] = "変更できませんでした"
        render "user/show"
      end 
  end 

  def destroy
    folder = Folder.find(params[:id])
    if folder.delete
      redirect_back(fallback_location: root_path)
    else
      flash[:notice] = "削除できませんでした"
      render 'files/index'
    end
  end 
  
  private
  
  # def folder_params
  #   # params.fetch(:folder, {}).permit(:article_id, :title, :url, :user_name)
  #   params.require(:folder).permit(:article_id, :title, :url, :user_name)
  # end 

end