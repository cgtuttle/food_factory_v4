class Inventory::ReceiptItem < ApplicationRecord
  belongs_to :receipt

  default_scope{ where(company_id: Security::Company.current_id)}

end
