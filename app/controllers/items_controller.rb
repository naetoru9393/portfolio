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

    def edit
      @item = Item.find(item_params)
    end
  
    def update
      @item = Item.find(params[:item_id ])
      @item.update(item_params)
    end

    def destroy
      @item = Item.find(item_params)
      @item.destroy
      redirect_to controller: :categories, action: :index
  end

  private

    def item_params
      params.require(:item).permit(:item_name, :study_time,
                                   :category_id, :item_id)
    end
  end

   # beforeフィルタ

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
end