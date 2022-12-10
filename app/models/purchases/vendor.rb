class Purchases::Vendor < ApplicationRecord
  has_one :account, as: :owner, class_name: "Settings::Account", dependent: :destroy
  delegate :addresses, to: :account
  
  has_many :orders, through: :account, source: :vendor_orders

  default_scope{ where(company_id: Security::Company.current_id)}

  def process_new
    ActiveRecord::Base.transaction do
      new_vendor = self.save!
      self.account.create(name: new_vendor.name, code: new_vendor.code)
    end
  end

end
