class FileName < ApplicationRecord
    validates :file_name, presence: true
    belongs_to :folder
end
