class Sales::Category < ApplicationRecord
  has_many :products, class_name: "Inventory::Product", dependent: :destroy

  default_scope{ where(company_id: Security::Company.current_id)}

end
