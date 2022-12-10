
namespace :data do
  desc "Save, drop, recreate, and seed the db"
  task rebuild: [ "db:structure:dump", "db:drop", "db:create", "db:structure:load", "db:seed"] do
    puts "All tasks completed" 
  end

  desc "Import a .CSV file from a given path"
  # rake data:import_csv[lib/assets/seed_data/Products.csv,Inventory::Product]
  task :import_csv, [:file, :model] => :environment do |t, args|
    require 'csv'
    items = []
    model_instance = Object.const_get args[:model]
    CSV.foreach(args[:file], headers: true) do |row|
      items << row.to_h
      puts row
    end
    imports = model_instance.import(items)
    puts "Imported #{imports.num_inserts} records."
  end
end
