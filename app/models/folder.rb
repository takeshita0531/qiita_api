class Folder < ApplicationRecord
    belongs_to :user
    before_save :set_json
    
    def qiita_id
        url.split('/').last
    end 
    
    private
    
    def set_json
        self.article_id = qiita_json
    end 
    
    def qiita_json
        url = "https://qiita.com/api/v2/items#{article_id}"
        uri = URI.parse(url)
        responce = Net::HTTP.get(uri)
        JSON.parse(responce)
    end 

end
