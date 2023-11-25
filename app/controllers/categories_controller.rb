class CategoriesController < ApplicationController
    def show
        @item = Item.all
    end
end