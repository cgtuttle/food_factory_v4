class Inventory::ItemLot < ApplicationRecord
  validates :lot_code, uniqueness: {scope: :item_id}
  
  belongs_to :item
  has_many :transactions
  has_many :item_locations, through: :item
  has_many :locations, through: :item_locations

  default_scope{ where(company_id: Security::Company.current_id)}

  def item_name
    self.item.name if self.item
  end

  def item_code
    self.item.code if self.item
  end

  def item_id
    self.item.id if self.item
  end

  def name
    self.item_name + " " + self.lot_code if self.item
  end

  def lot_format
    self.item.item_class.lot_format if self.item
  end
  
end
