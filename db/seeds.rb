# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

products = [
  Product.find_or_create_by(code: "ACCTSTARTER", description: "Starter Package", price: 249),
  Product.find_or_create_by(code: "ACCTGROWTH", description: "Growth Package", price: 349),
  Product.find_or_create_by(code: "ACCTROCKSTAR", description: "Rockstar Package", price: 549)
]

products.each do |product|
  product.promotions << FixedPromotion.find_or_create_by(frequency: 'fixed', amount_discount: 50, start_date: Date.new(2017,3,21), end_date: Date.new(2017, 03, 23))
  product.promotions << FixedPromotion.find_or_create_by(frequency: 'fixed', amount_discount: 100, start_date: Date.new(2017,3,22), end_date: Date.new(2017, 03, 24))
  product.promotions << FixedPromotion.find_or_create_by(frequency: 'fixed', amount_discount: 50, start_date: Date.new(2017,3,23), end_date: Date.new(2017, 03, 26))
end
