class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :update, :destroy]

  def new
    @category_id = params[:id]
    @month = params[:month]
    @current_user = current_user.id
    @item = Item.new

    if "1" == @category_id
      @name = "バックエンド"
    elsif "2" == @category_id
      @name = "フロントエンド"
    else
      @name = "インフラ"
    end

    session[:previous_url] = request.referer
  end


    def create
      @category_id = params[:id]
      @month = params[:month]
      @item = Item.new(item_params)
  
      if @item.save
        
      else
        session[:previous_url] = request.referer
        flash[:error] = "その項目はすでに存在します"
      end
    end
  
  
      def update
        @item = Item.find(params[:id])
        @item.update(item_params)
      end

      def destroy
        @item = Item.find(params[:id])
        @item.destroy
      end
      
  private

    def item_params
      params.require(:item).permit(:item_name, :study_time, :category_id,
                                   :id, :month, :user_id)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

  end