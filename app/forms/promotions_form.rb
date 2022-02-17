class PromotionsForm
  include ActiveModel::Model

  attr_accessor :code, :basket

  validates :code, inclusion: { in: PromotionCode.pluck(:code), message: "is invalid" }
  validate :code_can_be_combined

  def save
    return false unless valid?

    promo_code = PromotionCode.find_by(code: code)
    basket.promotion_codes << promo_code

    true
  end

  private

    def code_can_be_combined
      return if basket.promotion_codes.count.zero?

      if basket.promotion_codes.pluck(:can_combine).include?(false) ||
          !promotion_code.can_combine?
        errors.add(:base, :invalid, message: "Exclusive codes can't be used in conjuction with other codes")
      end
    end

    def promotion_code
      @promotion_code ||= PromotionCode.find_by(code: code)
    end
end
