module ApplicationHelper

  def flash_class(level)
    case level
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  def app_width_class(width_class = nil)
    if width_class
      width_class
    else
      case action_name
        when "index" then index_table_col_class
        else show_col_class
      end
    end
  end


  def show_col_class
    "col-xs-12 col-md-6 col-xl-4"
  end

  def previous_path
    session[:previous_path]
  end

  def previous_controller
    session[:previous_controller]
  end

  def previous_action
    session[:previous_action]
  end

  def previous_label
    case session[:previous_action]
      when "index" then session[:previous_controller].titlecase
      when "show" then session[:previous_controller].singularize.titlecase
      when "new" then "Add #{session[:previous_controller].singularize.titlecase}"
      else session[:previous_controller].singularize.titlecase
    end
  end

  def get_setting(class_name, setting_name)
    value = class_name.constantize.where("name = (?)", setting_name).pluck(:value).first
  end

  def sortable(column, title = nil)
    if defined? sort_column
      title ||= column.titleize
      direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
      link_to title, sort: column, direction: direction
    else
      title
    end
  end

  def content
    case action_name
      when "update" then "show"
      else action_name
    end
  end

  def app_page_title
    if action_name == "index"
      controller_name.titlecase
    else
      controller_name.titlecase.singularize
    end
  end

  def model_name_plural
    case controller_name
      when "orders" then "Sales Orders"
      when "items" then "Inventory Items"
      else controller_name.titlecase
    end
  end

  def index_title
  end

  def model_name_singular
    case controller_name
      when "orders" then "Sales Order"
      when "items" then "Inventory Item"
      when "addresses" then "Customer Address"
      else controller_name.titlecase.singularize
    end
  end

  def column_filter(column)
    render 'application/shared/column_filter'
  end

  def std_date(date_element)
    date_element.strftime("%m/%d/%Y") if date_element.present?
  end

  def default_date(date_element = Date.today)
    date_element.present? ? date_element.strftime("%Y-%m-%d") : Date.today.strftime("%Y-%m-%d")
  end

  def qty_1(qty_element)
    number_with_precision(qty_element, precision: 1, strip_insignificant_zeros: true, delimiter: ",")
  end 

  def number_2(number)
    number_with_precision((number.present? ? number : 0), precision: 2)
  end

  def id_6(id)
    id.to_s.rjust(6, '0')
  end

  def nil_to_zero(value)
    value.present? ? value : 0
  end

  def money_2(amount)
    amount.present? ? number_to_currency(amount, precision: 2) : 0
  end

  def money_4(amount)
    amount.present? ? number_to_currency(amount, precision: 4) : 0
  end

  def money(amount)
    amount.present? ? number_to_currency(amount, precision: 0) : 0
  end

end
