class Inventory::ItemClass < ApplicationRecord
  validates :code, uniqueness:{ scope: :company_id }
  has_many :items
  has_many :item_lots, through: :item

  default_scope{ where(company_id: Security::Company.current_id)}

  def product?
    self.product ? "Yes" : "No"
  end

end
