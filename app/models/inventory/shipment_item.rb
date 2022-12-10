class Inventory::ShipmentItem < ApplicationRecord
  belongs_to :shipment

  default_scope{ where(company_id: Security::Company.current_id)}

end
