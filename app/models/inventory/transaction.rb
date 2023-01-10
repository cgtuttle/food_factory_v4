class Inventory::Transaction < ApplicationRecord
  belongs_to :item
  belongs_to :item_lot
  belongs_to :location
  belongs_to :transaction_type
  belongs_to :source, polymorphic: true, optional: true

  default_scope{ where(company_id: Security::Company.current_id)}

  attribute :new_item_lot_code, :string
  attribute :expire_date, :date

  def net_change
    incr = self.base_qty_increase.present? ? base_qty_increase : 0
    decr = self.base_qty_decrease.present? ? base_qty_decrease : 0
    incr - decr
  end

  def self.running_sum_sql(**args)

    # Build SQL statement in three parts:
    #
    # sql_select
    # sql_where
    # sql_order
    #
    # And concatenate

    sql_select = "SELECT t.id, t.transaction_date, t.transaction_type_id, 
      t.base_qty_increase, t.base_qty_decrease, 
      t.item_id, t.item_lot_id, t.location_id, 
      i.code, i.name, i.item_class_id, i.base_unit_id,
      il.lot_code, il.expire_date,
      l.name, l.code, 
      SUM(t.base_qty_increase - t.base_qty_decrease) 
        OVER (PARTITION BY t.item_id 
              ORDER BY t.transaction_date, t.id)
        AS item_balance,
      SUM(t.base_qty_increase - t.base_qty_decrease) 
        OVER (PARTITION BY t.item_lot_id 
              ORDER BY t.transaction_date, t.id)
        AS item_lot_balance
    FROM application.inventory_transactions t 
    INNER JOIN application.inventory_items i ON t.item_id = i.id
    INNER JOIN application.inventory_item_lots il on t.item_lot_id = il.id
    INNER JOIN application.inventory_locations l on t.location_id = l.id "
    
    sql_where = ""

    if args.size > 0
      sql_where = "WHERE"
      i = 0
      args.each do |key, value|
        sql_where = sql_where + " AND" if i > 0 
        sql_where = sql_where + " t.#{key} = #{value}"
        i += 1
      end
    end

    sql_order = " ORDER BY t.transaction_date DESC, t.id DESC, t.item_id, t.item_lot_id"

    sql = sql_select + sql_where + sql_order

  end

  def self.with_running_sum(**args)
    
    puts "Running self.with_running_sum"
    
    find_by_sql(running_sum_sql(**args))
  end

  def item_code
    self.item.code
  end

  def item_name
    self.item.name
  end

  def lot_code
    self.item_lot.lot_code
  end

  def transaction_type_code
    self.transaction_type.code
  end

  def formatted_transaction_date
    self.transaction_date.strftime("%-m/%-d/%Y")
  end

# Arel section - not in use, window functions difficult to implement

  def self.list_filtered()
    item = Inventory::Item.arel_table
    item_lot = Inventory::ItemLot.arel_table
    transaction = Inventory::Transaction.arel_table
    joins(join(transaction, item, "item_id", "id")).
      joins(join(transaction, item_lot, "item_lot_id", "id"))
      where(predicate(transaction, "item_id", 2)).
      where(predicate(transaction, "item_lot_id", 19))
  end

  def self.join_on(table, join_table, foreign_key_name, join_key_name)
    table.create_on(table[foreign_key_name.to_sym].eq(join_table[join_key_name.to_sym]))
  end

  def self.join(table, join_table, foreign_key_name, join_key_name)
    table.create_join(join_table, join_on(table, join_table, foreign_key_name, join_key_name))
  end

  def self.predicate(table, column_name, value)
    table[column_name.to_sym].eq(value)
  end

  def self.sum_function(table, column_name)
    Arel::Nodes::NamedFunction.new('SUM', [table[column_name.to_sym]])
  end

# End of Arel section

end
