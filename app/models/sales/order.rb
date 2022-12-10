class Sales::Order < ApplicationRecord
  belongs_to :bill_to_address, class_name: "Settings::Address", optional: true
  belongs_to :ship_to_address, class_name: "Settings::Address", optional: true
  belongs_to :ship_from_address, class_name: "Settings::Address", optional: true
  belongs_to :customer_account, class_name: "Settings::Account"
  has_many :lines, class_name: "OrderLine", dependent: :destroy
  accepts_nested_attributes_for :lines, reject_if: proc { |attributes| attributes['line_number'].blank? }, allow_destroy: true

  default_scope{ where(company_id: Security::Company.current_id)}

  def self.next_order_number
    if Sales::Order.count > 0
      Sales::Order.maximum(:order_number) + 1
    else
      1
    end
  end

end
