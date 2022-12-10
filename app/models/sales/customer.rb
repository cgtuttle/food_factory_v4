class Sales::Customer < ApplicationRecord
  has_one :account, as: :owner, class_name: "Settings::Account", dependent: :destroy
  delegate :account_addresses, to: :account
  delegate :addresses, to: :account
  accepts_nested_attributes_for :account
  
  has_many :orders, through: :account, source: :customer_orders

  default_scope{ where(company_id: Security::Company.current_id)}

  def name
    self.account.name
  end

  def code
    self.account.code
  end

end
