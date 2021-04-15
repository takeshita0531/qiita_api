class Folder < ApplicationRecord
    belongs_to :user
    belongs_to :file
    
    def QiitaMemory.search(search) #self.はUser.を意味する
     if search
       where(['UPPER(title_memo) LIKE ?', "%#{search.upcase}%"])
     end
    end
end
