class Settings::Company < ApplicationRecord
  belongs_to :company, class_name: "Security::Company"

  default_scope{ where(company_id: Security::Company.current_id)}
  
end
