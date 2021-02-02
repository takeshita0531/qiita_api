class Folder < ApplicationRecord
    has_many :users
    
    def self.search(search)
       search ? where("title LIKE ?", "%#{search}%") : all
    end 
    # before_save :set_json
    
    # def qiita_id
    #     folder.article_id
    # end 
    
    # private
    
    # def set_json
    #     self.article_id = qiita_json
    # end 
    
    # def qiita_json
    #     url = "https://qiita.com/api/v2/items#{qiita_id}"
    #     uri = URI.parse(url)
    #     responce = Net::HTTP.get(uri)
    #     JSON.parse(responce)
    # end 

end
