class Settings::AccountAddress < ApplicationRecord
  belongs_to :account, optional: true
  belongs_to :address, optional: true

  default_scope{ where(company_id: Security::Company.current_id)}

end