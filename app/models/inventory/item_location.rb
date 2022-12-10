class Inventory::ItemLocation < ApplicationRecord
  belongs_to :item
  belongs_to :location

  default_scope{ where(company_id: Security::Company.current_id)}

end
