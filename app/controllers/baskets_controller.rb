class BasketsController < ApplicationController
  before_action :set_current_basket

  def destroy
    delete_current_basket

    redirect_to root_url, notice: "Your basket has been deleted"
  end
end
