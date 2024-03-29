class Api::QiitaApi
    
    attr_accessor :items, :qiita_url, :folder
    
    require 'net/http'
    require 'json'
  
  def qiita_api
    query = 'created:>2015-10-09'
    status, next_page, @items = QiitaApiManager.search(query)
  
    @qiita_url = []
    @items.each do |url|
      folder_url = Folder.find_by(url: url['url'])
      if folder_url.present?
          @qiita_url.push(folder_url.url)
      end
    end
  end
    
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
end