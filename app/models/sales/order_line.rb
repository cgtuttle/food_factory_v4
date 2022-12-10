class Sales::OrderLine < ApplicationRecord
  belongs_to :order

  default_scope{ where(company_id: Security::Company.current_id)}

  def item_description
    if self.item_id.present?
      Inventory::Item.find(self.item_id).name
    end
  end

end
