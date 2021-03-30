class FoldersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    query = 'created:>2015-10-09' 
    status, next_page, @items = QiitaApiManager.search(query)
    QiitaMemoryJob.perform_later
    @folder_new = Folder.new
    @folders = QiitaMemory.search(params[:search])
  end
  
  def create
      query = 'created:>2015-10-09'
      status, next_page, @items = QiitaApiManager.search(query)
      folder = Folder.new(folder_params)
      respond_to do |format|
      if folder.save
        format.html  {redirect_back(fallback_location: true)}
        format.js { render js: 'folders/create.js.erb' }
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
  
  
  require 'net/http'
  require 'json'
  
  

  class QiitaApiManager
    PER_PAGE = 100
    ACCESS_TOKEN = 'f0ac82b225df283fcbeee8dbb596b6feae29db03'
    GET_ITEMS_URI = 'https://qiita.com/api/v2/items'
  
    def self.search(query, page: 1)
      puts "API Search Condition: query:'#{query}', page:#{page}"
  
      # リクエスト情報を作成
      uri = URI.parse (GET_ITEMS_URI)
      uri.query = URI.encode_www_form({ query: query, per_page: PER_PAGE, page: page })
      req = Net::HTTP::Get.new(uri.request_uri)
      req['Authorization'] = "Bearer #{ACCESS_TOKEN}"
  
      # リクエスト送信
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      res = http.request(req)
  
      # 次ページを計算 (API仕様 上限は100ページ)
      total_page = ((res['total-count'].to_i - 1) / PER_PAGE) + 1
      total_page = (total_page > 100) ? 100 : total_page
      next_page = (page < total_page) ? page + 1 : nil
  
      # API 残り使用回数、リセットされる時刻を表示
      puts "API Limit:#{res['rate-remaining']}/#{res['rate-limit']}, reset:#{Time.at(res['rate-reset'].to_i)}"
  
      # 返却 [HTTPステータスコード, 次ページ, 記事情報の配列]
      return res.code.to_i, next_page, JSON.parse(res.body)
    end
  end
  
  private
  
  def folder_params
    params.fetch(:folder, {}).permit(:user_id, :article_id, :title, :url, :user_name)
  end 

end