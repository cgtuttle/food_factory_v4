require 'csv'

puts "Running seeds.rb"

directory = Dir.children(Rails.root.join('db/seed_data/'))

directory.sort.each do |filename|

  puts "filename: #{filename}"
  puts "last three letters: #{filename[-3, 3]}"
  short_filename = filename[3, filename.length - 3]
  if filename[-3, 3] == "csv"

    table_namespace_string = short_filename[0, short_filename.index("_")]
    table_name_string = short_filename[short_filename.index("_")..(short_filename.length - 5)]
    table_namespace = table_namespace_string.capitalize
    table_name = table_name_string.capitalize.camelcase
    model_name = "#{table_namespace}::#{table_name}".singularize
    db_table_name = "application.#{short_filename[0..(short_filename.length - 5)]}"

    puts "model_name: #{model_name}"

    CSV.foreach(Rails.root.join("db/seed_data/#{filename}"), headers: true) do |row|
      puts "row: #{row.inspect}"
      model_object = model_name.constantize.new(row.to_hash)
      puts "model_object: #{model_object.inspect}"
      model_object.save!
    end

    conn = ActiveRecord::Base.connection

    last_auto_increment = model_name.constantize.maximum(:id)

    if last_auto_increment.present?
      puts "last_auto_increment for #{db_table_name}: #{last_auto_increment}"
      next_auto_increment = last_auto_increment + 1
      
      conn.execute(
        "ALTER SEQUENCE #{db_table_name}_id_seq RESTART WITH #{next_auto_increment}"
      )
    end
  end
end
