module ApplicationHelper
  def price_in_euros(price)
    number_to_currency(price, unit: '€', format: "%n %u")
  end

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert alert-info'
    when :success then 'alert alert-success'
    when :alert then 'alert alert-danger'
    when :warning then 'alert alert-warning'
    else
      raise ArgumentError, "Invalid flash #{level.inspect}"
    end
  end
end
