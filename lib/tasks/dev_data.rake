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

  task :create_promotion_codes => :environment do
    CODES = [
      { code: '20%OFF', amount: 20.0, type: "PercentDiscount", can_combine: false },
      { code: '5%OFF', amount: 5.0, type: "PercentDiscount", can_combine: true },
      { code: '20EUROFF', amount: 20.00, type: "AmountDiscount", can_combine: true },
    ]

    CODES.each do |attributes|
      puts "Creating promotion code: #{attributes[:code]}"
      PromotionCode.find_or_create_by!(attributes)
    end
  end

  task :create_product_bundles => :environment do
    PRODUCT_BUNDLES = [
      { product_name: 'Motion Sensor', quantity: 3, price: 65.00 },
      { product_name: 'Smoke Sensor', quantity: 2, price: 35.00 },
    ]

    PRODUCT_BUNDLES.each do |attributes|
      product = Product.find_by!(name: attributes[:product_name])
      puts "Creating product bundle: #{attributes[:quantity]} x #{product.name}"
      ProductBundle.find_or_create_by!(attributes.except(:product_name).merge(product: product))
    end
  end

  task :fill_in => :environment do
    Rake::Task["dev_data:create_products"].execute
    Rake::Task["dev_data:create_promotion_codes"].execute
    Rake::Task["dev_data:create_product_bundles"].execute
  end
end
