class Settings::Unit < ApplicationRecord
  has_many :items

  default_scope{ where(company_id: Security::Company.current_id)}

end
