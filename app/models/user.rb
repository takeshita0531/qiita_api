class User < ApplicationRecord
  has_many :folders
  has_many :file_names
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def Folder.search(search)
      # return Folder.all unless search
      Folder.where(['title LIKE ?', "%#{search}%"])
      # Folder.where(['UPPER(title) LIKE ?', "%#{search.upcase}%"])
  end
end
