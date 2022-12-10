class Sales::ForecastWorksheet < ApplicationRecord
  belongs_to :inventory_product
  belongs_to :forecast

  default_scope{ where(company_id: Security::Company.current_id)}
  
end
