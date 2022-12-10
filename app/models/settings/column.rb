class Settings::Column < ApplicationRecord
  belongs_to :filter, dependent: :destroy

  default_scope{ where(company_id: Security::Company.current_id)}


end
