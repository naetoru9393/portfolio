class ApplicationController < ActionController::Base
    include SessionsHelper

    private

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  def set_current_user
    @current_user = current_user
  end
end
