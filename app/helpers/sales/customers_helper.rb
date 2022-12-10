module Sales::CustomersHelper
  def label_list
    label_list = [
      "ID",
      "Code",
      "Name"
    ]
    puts "label_list: #{label_list}"
    label_list
  end

  def field_list
    field_list = [
      "id",
      "code",
      "name"
    ]
  end
end