class FileName < ApplicationRecord
    validates :file_name, presence: true
    has_many:folders, dependent: :destroy
    
    def Folder.search(search)
        # return Folder.all unless search
        Folder.where(['title LIKE ?', "%#{search}%"])
        # Folder.where(['UPPER(title) LIKE ?', "%#{search.upcase}%"])
    end
end
