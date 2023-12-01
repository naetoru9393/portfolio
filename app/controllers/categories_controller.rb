class CategoriesController < ApplicationController

    def index
        @category = Category.new
        @backends = Item.where(category_id: 1)
        @frontends = Item.where(category_id: 2)
        @infrastructures = Item.where(category_id: 3)
    end
    
    
    def create
        @category = Category.new(category_params)
        @category.save
        redirect_to new_item_path(id: @category.id)
    end

    private

    def category_params
      params.require(:category).permit(:category_name, :id)
    end

end