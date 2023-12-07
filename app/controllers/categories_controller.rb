class CategoriesController < ApplicationController

    def index
        @months = Date.today.month
        @category = Category.new

        if params[:month] == nil
            @backends = Item.where(category_id: 1).where(month: @month)
            @frontends = Item.where(category_id: 2).where(month: @month)
            @infrastructures = Item.where(category_id: 3).where(month: @month)
            else
            @month = params[:month]
            @backends = Item.where(category_id: 1).where(month: @month)
            @frontends = Item.where(category_id: 2).where(month: @month)
            @infrastructures = Item.where(category_id: 3).where(month: @month)
            end  
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