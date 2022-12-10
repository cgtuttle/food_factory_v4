class Inventory::Product < ApplicationRecord
  belongs_to :item, optional: true
  belongs_to :category, class_name: "Sales::Category", optional: true
  belongs_to :channel, class_name: "Sales::Channel", optional: true

  default_scope{ where(company_id: Security::Company.current_id)}

end