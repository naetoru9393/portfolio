class Category < ApplicationRecord
    validates :category_name, :id, presence: true
    validates :category_name, :id, uniqueness: true
end
