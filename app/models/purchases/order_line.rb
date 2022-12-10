class Purchases::OrderLine < ApplicationRecord
  belongs_to :order

  default_scope{ where(company_id: Security::Company.current_id)}

end
