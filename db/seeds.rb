require "csv"

MERCHANT_FILE = Rails.root.join("db", "merchant-seeds.csv")
puts "Loading raw merchant data from #{MERCHANT_FILE}"

merchant_failures = []
CSV.foreach(MERCHANT_FILE, :headers => true) do |row|
  merchant = Merchant.new

  merchant.username = row["username"]
  merchant.email = row["email"]
  merchant.uid = row["uid"]
  merchant.provider = row["provider"]
  successful_mer = merchant.save

  if !successful_mer
    merchant_failures << merchant
    puts "Failed to save merchant: #{merchant.inspect}"
  else
    puts "Created merchant: #{merchant.inspect}"
  end
end

puts "Added #{Merchant.count} merchant records"
puts "#{merchant_failures.length} merchants failed to save"

PRODUCT_FILE = Rails.root.join("db", "product-seeds.csv")
puts "Loading raw product data from #{PRODUCT_FILE}"

product_failures = []
CSV.foreach(PRODUCT_FILE, :headers => true) do |row|
  product = Product.new

  product.name = row["name"]
  product.price = row["price"]
  product.quantity = row["quantity"]
  product.merchant_id = row["merchant_id"]
  product.description = row["description"]
  product.photo_url = row["photo_url"]
  product.status = row["status"]

  successful_prod = product.save

  if !successful_prod
    product_failures << product
    puts "Failed to save product: #{product.inspect}"
  else
    puts "Created product: #{product.inspect}"
  end
end

puts "Added #{Product.count} product records"
puts "#{product_failures.length} products failed to save"

CATEGORY_FILE = Rails.root.join("db", "category-seeds.csv")
puts "Loading raw category data from #{CATEGORY_FILE}"

category_failures = []
CSV.foreach(CATEGORY_FILE, :headers => true) do |row|
  category = CATEGORY.new

  category.name = row["name"]

  successful_cat = category.save

  if !successful_cat
    category_failures << category
    puts "Failed to save category: #{category.inspect}"
  else
    puts "Created category: #{category.inspect}"
  end
end

puts "Added #{Category.count} category records"
puts "#{category_failures.length} categories failed to save"

ORDER_FILE = Rails.root.join("db", "order-seeds.csv")
puts "Loading raw order data from #{ORDER_FILE}"

order_failures = []
CSV.foreach(ORDER_FILE, :headers => true) do |row|
  order = Order.new

  order.name = row["name"]
  order.address = row["address"]
  order.email = row["email"]
  order.credit_card_num = row["credit_card_num"]
  order.expiration_date = row["expiration_date"]
  order.cvv = row["cvv"]
  order.zip = row["zip"]
  order.status = row["status"]
  # total_price, placed_time??

  successful_ord = order.save

  if !successful_ord
    order_failures << order
    puts "Failed to save order: #{order.inspect}"
  else
    puts "Created order: #{order.inspect}"
  end
end

puts "Added #{Order.count} order records"
puts "#{order_failures.length} orders failed to save"
