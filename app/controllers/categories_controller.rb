class CategoriesController < ApplicationController

    def show
        @category = Category.new
        @items = Item.all
        @item = Item.new
      
    end

    def new
        @category = Category.new
        @item = Item.new
    end
    
    def create
        @category = Category.new(category_params)
        @category.save
        redirect_to new_item_path(category_id: @category.category_id)
    end

    private

    def category_params
      params.require(:category).permit(:category_name, :category_id)
    end

    def item_params
    params.require(:item).permit(:item_name, :study_time, :category_id)
    end

end