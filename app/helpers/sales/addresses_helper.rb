module Sales::AddressesHelper

  def path_label
    puts "previous_label: #{previous_label}"
    if previous_label == "Customer"
      @customer.name
    else
      previous_label
    end
  end

  
  def label_list
    label_list = [
      "ID",
      "Code",
      "Name",
      "Line 1",
      "Line 2",
      "City",
      "State",
      "Postal Code"
    ]
    puts "label_list: #{label_list}"
    label_list
  end

  def field_list
    field_list = [
      "id",
      "code",
      "name",
      "address_1",
      "address_2",
      "city",
      "state",
      "postal_code"
    ]
  end

end