class Sales::RetailChain < ApplicationRecord
  belongs_to :distributor

  default_scope{ where(company_id: Security::Company.current_id)}

end
