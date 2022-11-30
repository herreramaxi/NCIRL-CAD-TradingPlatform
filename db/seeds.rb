# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Administrator.create(first_name: 'admin', last_name: 'admin', email: 'admin@domain.com',
                             password: ENV['USER_PASSWORD'])
portfolioManager = PortfolioManager.create(first_name: 'portfolioManager', last_name: 'portfolioManagerLastName',
                                           email: 'portfolioManager@mhTrading.com', password: ENV['USER_PASSWORD'])
5.times do |i|
  portfolioManager.traders.create(first_name: "trader#{i}", last_name: "lastName#{i}",
                                  email: "trader#{i}@mhTrading.com", password: ENV['USER_PASSWORD'], balance: 15_000)
end
# C:\dev\RubyOnRails\cloudProjectMH\db\nasdaq_screener_reduced.csv
require 'csv'
# require_relative './nasdaq_screener_reduced.csv'
csvPath = Rails.root.join('db', 'nasdaq_screener_reduced.csv')
puts csvPath
csv_text = File.read(csvPath)
csv = CSV.parse(csv_text, headers: true)
csv.each do |row|
  StockSymbol.create!(symbol: row.to_hash['Symbol'],
                      name: row.to_hash['Name'],
                      country: row.to_hash['Country'],
                      ipo_year: row.to_hash['IPO YEAR'],
                      sector: row.to_hash['Sector'],
                      industry: row.to_hash['Industry'])
end
