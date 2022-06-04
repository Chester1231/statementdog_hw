# frozen_string_literal: true
class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_token])
  end

  def user_signed_in?
    current_user != nil
  end

  def authenticate_user!
    redirect_to root_path, notice: '請登入會員' if not user_signed_in?
  end
end
