class Category < ApplicationRecord
    has_many :items
    validates :category_name, :id, presence: true
    validates :category_name, :id, uniqueness: true
end
