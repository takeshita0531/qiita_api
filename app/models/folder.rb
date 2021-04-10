class Folder < ApplicationRecord
    belongs_to :user
    belongs_to :file
    
    def QiitaMemory.search(search) #self.はUser.を意味する
     if search
       where(['title_memo LIKE ?', "%#{search}%"])
     end
    end
end
