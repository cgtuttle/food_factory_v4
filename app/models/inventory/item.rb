class Inventory::Item < ApplicationRecord
  belongs_to :inventory_class, class_name: "ItemClass", foreign_key: "item_class_id"
  belongs_to :base_unit, class_name: "Settings::Unit"
  has_many :item_locations
  has_many :locations, through: :item_locations
  has_many :lots, class_name: "ItemLot", dependent: :destroy
  has_many :transactions
  has_many :products

  default_scope{ where(company_id: Security::Company.current_id)}

  def code_with_name
    "#{self.code} - #{self.name}"
  end

  def inventory_class_name
    self.inventory_class.name
  end

  def base_unit_code
    self.base_unit.code
  end

  def inventory_balance(last_entry = self.transactions.maximum(:transaction_date))
    increases = self.transactions.where("transaction_date <= ?", last_entry).sum(:base_qty_increase)
    decreases = self.transactions.where("transaction_date <= ?", last_entry).sum(:base_qty_decrease)
    increases - decreases
  end

  def lot_inventory_balance(lot_id, last_entry = self.transactions.maximum(:transaction_date))
    increases = self.transactions.where("transaction_date <= ? AND item_lot_id = ?", last_entry, lot_id).sum(:base_qty_increase)
    decreases = self.transactions.where("transaction_date <= ? AND item_lot_id = ?", last_entry, lot_id).sum(:base_qty_decrease)
    increases - decreases
  end
  
end
