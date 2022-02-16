class BasketsController < ApplicationController
  before_action :set_current_basket

  def destroy
    @current_basket.destroy
    session[:basket_id] = nil

    redirect_to root_url, notice: "Your basket has been deleted"
  end
end
