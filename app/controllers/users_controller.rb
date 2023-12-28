class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]

    def show
      @user = User.find(params[:id])
      @month = Date.today.month
      @user_item = Item.where(user_id: @user.id)
      @back_this_manth = @user_item.where(category_id:1).where(month:@month).sum(:study_time)
      @back_last_manth = @user_item.where(category_id:1).where(month:@month-1).sum(:study_time)
      @back_two_manths_ago = @user_item.where(category_id:1).where(month:@month-2).sum(:study_time)

      @front_this_manth = @user_item.where(category_id:2).where(month:@month).sum(:study_time)
      @front_last_manth = @user_item.where(category_id:2).where(month:@month-1).sum(:study_time)
      @front_two_manths_ago = @user_item.where(category_id:2).where(month:@month-2).sum(:study_time)

      @infra_this_manth = @user_item.where(category_id:3).where(month:@month).sum(:study_time)
      @infra_last_manth = @user_item.where(category_id:3).where(month:@month-1).sum(:study_time)
      @infra_two_manths_ago = @user_item.where(category_id:3).where(month:@month-2).sum(:study_time)
    end
  
    def new
      @user = User.new
    end
  
    def create
        @user = User.new(user_params)
        if @user.save
          reset_session
          log_in @user
          redirect_to @user
        else
          render 'new'
        end
      end
    
      def edit
        @user = User.find(params[:id])
      end
    
      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          flash[:success] = "Profile updated"
          redirect_to @user
        else
          render 'edit', status: :unprocessable_entity
        end
      end
  
    private

      def user_params
        params.require(:user).permit(:name, :email, :password,
                                     :introduction, :image)
      end

      # beforeフィルタ

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
      
        # セッションに保存されたユーザーIDと編集しようとしているユーザーIDが一致しない場合、ログアウトさせる
        unless session[:user_id] == @user.id
          reset_session
          flash[:danger] = "Unauthorized access. Please log in again."
          redirect_to login_url, status: :see_other
        end
      end

      def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
      end
    
      def forget
        update_attribute(:remember_digest, nil)
      end
  end