class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create
      @item = Item.new(item_params)
      @item.save
    end
  
    def update
      @item = Item.find(item_params)
      @item.update(user_params)
    end

  private

    def item_params
      params.require(:item).permit(:item_name, :study_time, :category_id)
    end
  end