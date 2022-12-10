module Sales::OrdersHelper

  def formatted_order_number(order_number)
    class_name = "Settings::Company"
    length = get_setting(class_name, "sales_order_number_length")
    pad = get_setting(class_name, "sales_order_number_pad").to_i == 1
    if pad
      format_string = "%0" + length + "d"
      format(format_string, order_number)
    else
      order_number
    end    
  end

  def order_info(order)
    "Id: #{order.id.to_s}<br>Source: #{order.class.name}<br>Lines: #{order.lines.count.to_s}"
  end

end