class ItemsController < ApplicationController

  def new
    @category_id = params[:id]
    @item = Item.new
  end

  def create
      @category_id = params[:id]
      @item = Item.new(item_params)
      @item.save
      redirect_to controller: :categories, action: :index
    end
  
    def update
      @item = Item.find(params[:id])
      @item.update(item_params)
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to controller: :categories, action: :index
  end

  private

    def item_params
      params.require(:item).permit(:item_name, :study_time, :category_id, :id)
    end
  end