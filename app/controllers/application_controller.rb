class ApplicationController < ActionController::Base
  def set_current_basket
    @current_basket = Basket.find(session[:basket_id])
  rescue ActiveRecord::RecordNotFound
    @current_basket = Basket.create
    session[:basket_id] = @current_basket.id
  end

  def basket_present?
    session[:basket_id].present?
  end
end
