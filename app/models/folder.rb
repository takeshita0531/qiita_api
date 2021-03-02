class Folder < ApplicationRecord
    has_many :users
    has_many :file_names
    def self.search(search) #self.はUser.を意味する
     if search
       where(['title LIKE ?', "%#{search}%"]) #検索とuseanameの部分一致を表示。
     else
       all #全て表示させる
     end
    end
    # def self.search(search)
    #   search ? where("title LIKE ?", "%#{search}%") : all
    # end 
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
