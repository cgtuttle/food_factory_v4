class Settings::Filter < ApplicationRecord
  has_many :columns
  accepts_nested_attributes_for :columns

  default_scope{ where(company_id: Security::Company.current_id)}

  def apply(collection)
    logger.debug "self: #{self.inspect}"
    collection.where(self.predicate)
  end

  def predicate
    resource_table = self.source_model.constantize.arel_table
    @search_predicate = resource_table[:id].gteq(0)
    self.columns.each do |column|
      @search_predicate = @search_predicate.and(resource_table[column.attribute_name.to_sym].eq(column.search_string))
    end
    return @search_predicate
  end

end
