class FoldersController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @folder = Folder.new
  end 
  
  def top
  end 
  
  def index
    query = 'created:>2015-10-09' # 参考 検索時に利用できるオプション
    status, next_page, @items = QiitaApiManager.search(query)
    QiitaMemoryJob.set(wait: 4.hour).perform_later
    @folder = Folder.new(folder_params)
    @folder.save
    # @folder_search = @items.where(title: params[:sear])
    # @items.each do |item|
      # @folder = item['title']
    @folders = QiitaMemory.search(params[:search])
    # @qiita_memo = @folders.select(:title_memo).distinct
    
#     sql = 'SELECT title_memo, url_memo, user_memo, create_at_memo FROM qiita_memories GROUP BY title_memo, url_memo, user_memo, create_at_memo HAVING COUNT(*) > 1;'
#     duplicates = QiitaMemory.find_by_sql(sql)
#     duplicate_ids = duplicates.inject([]) do |duplicate_ids, dup|
#     articles = QiitaMemory.select(:id).where(title_memo: dup.title_memo, url_memo: dup.url_memo, user_memo: dup.user_memo, create_at_memo: dup.create_at_memo) 
#     duplicate_ids << articles.pluck(:id)[1..-1]
#     end

# # 重複したレコードのIDを削除する
#     QiitaMemory.where(id: duplicate_ids.flatten).destroy_all
    
    # end 
    # @items.delay
    # redirect_to folders_path
  end
  
  def delay
    # query = 'created:>2015-10-09' # 参考 検索時に利用できるオプション
    # status, next_page, @items = QiitaApiManager.search(query)
    # @items.delay
    # QiitaMemoryJob.perform_later(@items) 
  end 
  
  def show
    # query = 'created:>2015-10-09' # 参考 検索時に利用できるオプション
    # status, next_page, @items = QiitaApiManager.search(query)
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