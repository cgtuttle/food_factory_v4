class Settings::AccountRelationship < ApplicationRecord
  belongs_to :parent_account, class_name: "Settings::Account", foreign_key: :parent_id
  belongs_to :child_account, class_name: "Settings::Account", foreign_key: :child_id

  default_scope{ where(company_id: Security::Company.current_id)}

end