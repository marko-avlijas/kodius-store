class OrdersController < ApplicationController
  before_action :ensure_basket_present, only: [:new, :create]
  before_action :set_order, only: [:show]

  # GET /orders/new
  def new
    @user = User.new
    @user.build_address
    @user.build_credit_card
  end

  # POST /orders or /orders.json
  def create
    @user = User.new(user_params)

    if @user.save
      order = Order.create(user: @user)
      set_current_basket
      order.transfer_line_items_and_promotions_from_basket(@current_basket)

      @current_basket.reload # avoid deleting transfered line items & promotions
      delete_current_basket

      redirect_to order_url(order), notice: "Order was successfully created."
    else
      logger.debug @user.errors.details
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:email,
                                   address_attributes: [:city, :country, :line1, :line2],
                                   credit_card_attributes: [:number, :expiry_date, :cvv2]
                                  )
    end

    def set_order
      @order = Order.find(params[:id])
    end

    def ensure_basket_present
      redirect_to root_url, notice: "Please add items to cart before you place an order" unless basket_present?
    end
end
