class CategoriesController < ApplicationController

    def show
        @category = Category.all
        @item = Item.all
    end

    def new
        @category = Category.new
        @item = Item.new
      end
    
      def create
          @category = Category.new(category_params)
          @category.save
        end
      
        def update
            @category = Category.find(category_params)
            @category.update(category_params)
        end

    private

    def category_params
      params.require(:category).permit(:category_name, :category_id)
    end

end