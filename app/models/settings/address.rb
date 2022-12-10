class Settings::Address < ApplicationRecord
  has_many :account_addresses
  has_many :purchase_bills, class_name: "PurchOrder", foreign_key: :bill_to_address_id
  has_many :purchase_shipments, class_name: "PurchOrder", foreign_key: :ship_to_address_id
  has_many :purchase_receipts, class_name: "PurchOrder", foreign_key: :ship_from_address_id
  has_many :sales_bills, class_name: "SalesOrder", foreign_key: :bill_to_address_id
  has_many :sales_shipments, class_name: "SalesOrder", foreign_key: :ship_to_address_id
  has_many :sales_receipts, class_name: "SalesOrder", foreign_key: :ship_from_address_id

  default_scope{ where(company_id: Security::Company.current_id)}

  def line_display
    line_1 = self.line_1.present? ? "#{self.line_1}, " : ""
    line_2 = self.line_2.present? ? "#{self.line_2}, " : ""
    city = self.city.present? ? "#{self.city}, " : ""
    state = self.state.present? ? "#{self.state} " : ""
    code = self.postal_code.present? ? "#{self.postal_code} " : ""
    country = self.country_code.present? ? "#{self.country_code}" : ""
    line_1 + line_2 + city + state + code + country
  end

  def block_display
    line_1 = self.line_1.present? ? "#{self.line_1}, " : ""
    line_2 = self.line_2.present? ? "#{self.line_2}, " : ""
    city = self.city.present? ? "#{self.city}, " : ""
    state = self.state.present? ? "#{self.state} " : ""
    code = self.postal_code.present? ? "#{self.postal_code} " : ""
    country = self.country_code.present? ? "#{self.country_code}" : ""
    line_1 + line_2 + city + state + code + country
  end


end
