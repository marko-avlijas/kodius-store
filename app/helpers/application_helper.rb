module ApplicationHelper
  def price_in_euros(price)
    number_to_currency(price, unit: '€', format: "%n %u")
  end
end
