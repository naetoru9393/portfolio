class Category < ApplicationRecord
    validates :category_name, :category_id, presence: true
    validates :category_name, :category_id, uniqueness: true
end
