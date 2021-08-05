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
    # # url = @qiita_api.items
    # @qiita_url = []
    # @qiita_api.items.each do |url|
    #   url = Folder.find_by
    # # folders = Folder.all
    # # @qiita_url = Folder.select("url")
    # #   binding.pry
    # end
  end
  
  def create
      @qiita_api = Api::QiitaApi.new
      @qiita_api.qiita_api
      @folder_new = Folder.new
      #   # @qiita_api.items.each do |url|
      #     @qiita_url = Folder.all
        # end
      folder = current_user.folders.new(folder_params)
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
  
  def folder_params
    params.fetch(:folder, {}).permit(:user_id, :article_id, :title, :url, :user_name)
  end 

end