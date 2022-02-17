module PriceCalculation
  extend ActiveSupport::Concern

  def total_before_promotions
    @total_before_promotions ||= line_items.to_a.sum { |item| item.total_price }.round(2)
  end

  def total
    @total ||= total_before_promotions +
      promotion_codes.to_a.sum { |code| code.apply_to(total_before_promotions) }.round(2)
  end
end
