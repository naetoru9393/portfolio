class ItemsController < ApplicationController

  def new
    @category_id = params[:id]
    @current_user = current_user.id
    @month = Date.today.month
    @item = Item.new
    session[:previous_url] = request.referer
  end

  def create
      @category_id = params[:id]
      @item = Item.new(item_params)
      @item.save
      redirect_to session[:previous_url]
    end
  
    def update
      @item = Item.find(params[:id])
      @item.update(item_params)
    end

    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_back(fallback_location: root_path)
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

    # 正しいユーザーかどうか確認
  def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
  end