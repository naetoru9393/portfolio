class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :create

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

    #def create
    #  @category_id = params[:id]
    #  @month = params[:month]
    #  @item = Item.new(item_params)
    #  @item.save
    #end

    def create
      # ... 他の処理 ...
      @category_id = params[:item][:category_id]
      @month = params[:item][:month]
  
      # トランザクションを開始
      ActiveRecord::Base.transaction do
        # アイテムの重複検出
        if Item.exists?(item_params)
          # 重複が検出された場合の処理
          render json: { duplicate_detected: true }
        else
          # 重複が検出されなかった場合の処理
          @item = Item.new(item_params)
          if @item.save
            render json: { duplicate_detected: false, name: current_user.name }
          else
            render json: { error: @item.errors.full_messages.join(', ') }, status: :unprocessable_entity
          end
        end
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
  