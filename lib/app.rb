require 'json'
require 'date'

path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

# Print today's date
puts Date.today.strftime('%A, %B %d, %Y')

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "
puts

# Calculate the max title length
titles = []
products_hash['items'].each do |toy|
  titles.push toy['title']
end
max_title_length = 0
titles.each do |title|
  max_title_length = title.length if title.length > max_title_length
end

# For each product in the data set:
products_hash['items'].each do |toy|
  # Print the name of the toy
  puts toy['title']
  puts '*' * max_title_length

  # Print the retail price of the toy
  retail_sales = toy['full-price'].to_f
  puts "Retail Price: $#{retail_sales}"

  # Calculate and print the total number of purchases
  num_purchases = toy['purchases'].length
  puts "Total Purchase: #{num_purchases}"

  # Calculate and print the total amount of sales
  total_sales = 0
  toy['purchases'].each do |purchase|
    total_sales += purchase['price']
  end
  puts "Total Sales: $#{total_sales}"

  # Calculate and print the average price the toy sold for
  avg_sales = total_sales / num_purchases
  puts "Average Price: $#{avg_sales}"

  # Calc and print the avg discount (% or $) based off the avg sales price
  avg_discount = (retail_sales - avg_sales) / retail_sales * 100
  avg_discount = avg_discount.round(2)
  puts "Average Discount: #{avg_discount}%"
  puts '*' * max_title_length
  puts
end

puts " _                         _     "
puts "| |                       | |    "
puts "| |__  _ __ __ _ _ __   __| |___ "
puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
puts "| |_) | | | (_| | | | | (_| \\__ \\"
puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
puts

# Generate unique brand array
brands = []
products_hash['items'].each { |toy| brands.push toy['brand'] }
brands = brands.uniq

# For each brand in the data set:
brands.each do |brand|
  # Print the name of the brand
  puts brand
  puts '*' * max_title_length

  # Count and print the number of the brand's toys we stock
  cnt_brand = 0
  products_hash['items'].each { |toy| cnt_brand += 1 if toy['brand'] == brand }

  puts "Numbers of Products: #{cnt_brand}"

  # Calculate and print the average price of the brand's toys
  total_price = 0
  products_hash['items'].each do |toy|
    total_price += toy['full-price'].to_f if toy['brand'] == brand
  end
  avg_price = (total_price / cnt_brand).round(2)
  puts "Average Product Price: $#{avg_price}"

  # Calculate and print the total revenue of all the brand's toy sales combined
  total_revenue = 0
  products_hash['items'].each do |toy|
    if toy['brand'] == brand
      toy['purchases'].each do |purchase|
        total_revenue += purchase['price']
      end
    end
  end
  total_revenue = total_revenue.round(2)
  puts "Total Sales: $#{total_revenue}"
  puts
end
