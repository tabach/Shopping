class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #devise
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :find_current_order

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password,
      :password_confirmation, :current_password, :avatar, :avatar_cache) }
  end

  helper_method :current_order

  def current_order
    @order || Order.new
  end

  private
  def find_current_order
    @order = Order.find_by_id(session[:order_id])
    @order = Order.new if @order.blank?
  end
end
