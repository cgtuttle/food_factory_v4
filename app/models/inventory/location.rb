class Inventory::Location < ApplicationRecord
  has_one :account, as: :owner, class_name: "Settings::Account"
  has_many :account_addresses, through: :account, class_name: "Settings::AccountAddress"
  has_many :item_locations
  has_many :items, through: :item_locations

  default_scope{ where(company_id: Security::Company.current_id)}

end
