class Inventory::Shipment < ApplicationRecord
  has_many :shipment_items

  default_scope{ where(company_id: Security::Company.current_id)}

end
