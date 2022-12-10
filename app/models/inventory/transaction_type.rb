class Inventory::TransactionType < ApplicationRecord
  has_many :transactions

  default_scope{ where(company_id: Security::Company.current_id)}
  
end
