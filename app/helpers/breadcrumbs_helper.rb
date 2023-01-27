module BreadcrumbsHelper

  def pathnames(path)
    Pathname.new(path).each_filename
  end

  def module(path)
    pathnames(path).first
  end

  def row_id(path, action)
    if ["show", "edit"].include?(action)
      pathnames(path).last
    end
  end

  def page_name(path, action)
    pathnames = pathnames(path).to_a
    case action
    when "show"
      puts "action = show"
      name = pathnames[-2].singularize
    when "edit"
      puts "action = edit"
      name = pathnames[-2].singularize
    when "index"
      puts "action = index"
      name = pathnames[-1]
    else
      puts "action = other"
      name = ""
    end
  end
    
end