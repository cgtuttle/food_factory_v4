class Inventory::Receipt < ApplicationRecord
  has_many :receipt_items

  default_scope{ where(company_id: Security::Company.current_id)}

end
