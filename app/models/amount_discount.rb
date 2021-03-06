# == Schema Information
#
# Table name: promotion_codes
#
#  id          :bigint           not null, primary key
#  amount      :decimal(8, 2)    not null
#  can_combine :boolean          default(FALSE), not null
#  code        :string           not null
#  type        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class AmountDiscount < PromotionCode
  def name
    "#{amount} € off"
  end

  def apply_to(total)
    - amount
  end
end

