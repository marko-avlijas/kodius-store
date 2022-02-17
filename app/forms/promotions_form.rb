class PromotionsForm
  include ActiveModel::Model

  attr_accessor :code, :basket

  validates :code, inclusion: { in: PromotionCode.pluck(:code), message: "Invalid code" }

  def save
    return false unless valid?

    promo_code = PromotionCode.find_by(code: code)
    basket.promotion_codes << promo_code

    true
  end
end
