class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :create]
  before_action :correct_user, only: [:create] # index アクションを除外

  def index
    @this_month = Date.today.month
    @last_month = Date.today.months_ago(1).month
    @months_ago = Date.today.months_ago(2).month
    @user = current_user
    @category = Category.new
    @items = Item.where(user_id: @user)

    if params[:month] == nil
      @month = @this_month
      @backends = @items.where(category_id: 1).where(month: @month)
      @frontends = @items.where(category_id: 2).where(month: @month)
      @infrastructures = @items.where(category_id: 3).where(month: @month)
    else
      @month = params[:month]
      @backends = @items.where(category_id: 1).where(month: @month)
      @frontends = @items.where(category_id: 2).where(month: @month)
      @infrastructures = @items.where(category_id: 3).where(month: @month)
    end
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to new_item_path(month: @category.month, id: @category.id)
  end

  private

  def category_params
    params.require(:category).permit(:category_name, :id, :month)
  end

  def correct_user
    @user = current_user # ユーザー ID を取得する方法を修正

    # セッションに保存されたユーザーIDとカテゴリ一覧を表示しようとしているユーザーIDが一致しない場合、ログアウトさせる
    unless session[:user_id] == @user.id
      reset_session
      flash[:danger] = "Unauthorized access. Please log in again."
      redirect_to login_url, status: :see_other
    end
  end
end
