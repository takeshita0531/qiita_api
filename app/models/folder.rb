class Folder < ApplicationRecord
    belongs_to :user
    
    # def self.search(search)
    #     if search
    #         Folder.where(['article_id LIKE ?', "%#{search}"])
    #     else
    #         Folder.all
    #     end 
    # end

end
