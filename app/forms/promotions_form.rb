class PromotionsForm
  include ActiveModel::Model

  attr_accessor :code, :basket

  ALLOWED_CODES = PromotionCode.pluck(:code)

  validates :code, inclusion: { in: ALLOWED_CODES, message: "is invalid" }
  validate :code_can_be_combined
  validate :code_is_not_already_applied

  def save
    return false unless valid?

    basket.promotion_codes << promotion_code

    true
  end

  private

    def code_can_be_combined
      return if !valid_code? || basket.promotion_codes.count.zero?

      if basket_contains_promo_codes_that_cannot_combine? ||
          !promotion_code.can_combine?
        errors.add(:base, :invalid, message: "Exclusive codes can't be used in conjuction with other codes")
      end
    end

    def code_is_not_already_applied
      return unless valid_code? && basket.promotion_code_ids.include?(promotion_code.id)

      errors.add(:code, :taken, message: "has already been applied")
    end

    def valid_code?
      ALLOWED_CODES.include?(code)
    end

    def basket_contains_promo_codes_that_cannot_combine?
      basket.promotion_codes.pluck(:can_combine).include?(false)
    end

    def promotion_code
      @promotion_code ||= PromotionCode.find_by(code: code)
    end
end
