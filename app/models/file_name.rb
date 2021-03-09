class FileName < ApplicationRecord
    validates :file_name, presence: true
    has_many:folders, dependent: :destroy
end
