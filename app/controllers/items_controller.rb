class ItemsController < ApplicationController

  def new
    @category_id = params[:category_id]
    @item = Item.new
  end

  def create
      @category_id = params[:category_id]
      @item = Item.new(item_params)
      @item.save
    end
  
    def update
      @item = Item.find(item_params)
      @item.update(user_params)
    end

    def delete
      @item = Item.find(item_params)
      @item.destroy
      redirect_to controller: :categories, action: :show
  end

  private

    def item_params
      params.require(:item).permit(:item_name, :study_time,
                                   :category_id, :item_id)
    end
  end