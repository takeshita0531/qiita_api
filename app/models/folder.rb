class Folder < ApplicationRecord
    has_many :users
    has_many :file_names
    def QiitaMemory.search(search) #self.はUser.を意味する
     if search
       where(['title_memo LIKE ?', "%#{search}%"])
     end
    end
end
