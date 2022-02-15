namespace :dev_data do
  task :create_products => :environment do
    PRODUCTS = [
      { name: 'Smart Hub', price: 49.99 },
      { name: 'Motion Sensor', price: 24.99 },
      { name: 'Wireless Camera', price: 99.99 },
      { name: 'Smoke Sensor', price: 19.99 },
      { name: 'Water Leak Sensor', price: 14.99 },
    ]

    PRODUCTS.each do |attributes|
      puts "Creating product: #{attributes[:name]}"
      Product.find_or_create_by!(attributes)
    end
  end

  task :fill_in => :environment do
    Rake::Task["dev_data:create_products"].execute
  end
end
