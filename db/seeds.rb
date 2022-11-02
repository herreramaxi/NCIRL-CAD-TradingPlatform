# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = Administrator.create( first_name: "admin", last_name:"admin",email:"admin@domain.com", password: ENV["USER_PASSWORD"] )
portfolioManager = PortfolioManager.create( first_name: "portfolioManager", last_name:"portfolioManagerLastName",email:"portfolioManager@domain.com", password: ENV["USER_PASSWORD"] )
5.times do |i|    
    portfolioManager.traders.create( first_name: "trader#{i}", last_name:"lastName#{i}",email:"email#{i}@domain.com", password: ENV["USER_PASSWORD"], balance: 15000 )
end