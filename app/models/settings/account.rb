class Settings::Account < ApplicationRecord
  has_many :account_addresses
  has_many :addresses, through: :account_addresses
  belongs_to :owner, polymorphic: true, dependent: :destroy

  has_many :customer_orders, class_name: "Sales::Order", foreign_key: "customer_account_id"
  has_many :ship_to_orders, class_name: "Sales::Order", foreign_key: "ship_to_account_id"
  has_many :ship_from_orders, class_name: "Sales::Order", foreign_key: "ship_from_account_id"

  has_many :vendor_orders, class_name: "Purchases::Order", foreign_key: "vendor_account_id"
  has_many :ship_from_purchases, class_name: "Purchases::Order", foreign_key: "ship_from_account_id"
  has_many :ship_to_purchases, class_name: "Purchases::Order", foreign_key: "ship_to_account_id"

  has_many :parent_relationships, class_name: "Settings::AccountRelationship", foreign_key: "parent_id"
  has_many :child_relationships, class_name: "Settings::AccountRelationship", foreign_key: "child_id"
  has_many :parent_accounts, through: :parent_relationships
  has_many :child_accounts, through: :child_relationships

  default_scope{ where(company_id: Security::Company.current_id)}

end
