class Sales::Forecast < ApplicationRecord

  default_scope{ where(company_id: Security::Company.current_id)}

end
