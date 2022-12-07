class AddBaseData < SeedMigration::Migration
  def up
    Administrator.create(first_name: 'admin', last_name: 'admin', accountName: 'admin',
                         email: 'admin@mhTrading.com', password: ENV['USER_PASSWORD'])
    portfolioManager = PortfolioManager.create(first_name: 'portfolioManager', last_name: 'portfolioManagerLastName',
                                               accountName: 'portfolioManager', email: 'portfolioManager@mhTrading.com', password: ENV['USER_PASSWORD'])
    5.times do |i|
      portfolioManager.traders.create(first_name: "trader#{i}", last_name: "lastName#{i}", accountName: "trader#{i}",
                                      email: "trader#{i}@mhTrading.com", password: ENV['USER_PASSWORD'], balance: 15_000)
    end

    require 'csv'
    stockSymbolFile = 'nasdaq_screener_reduced.csv'
    csvPath = Rails.root.join('db', stockSymbolFile)
    puts "Importing stock symbols from #{csvPath}"

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
  end

  def down
    Trader.delete_all
    PortfolioManager.delete_all
    Administrator.delete_all
    StockSymbol.delete_all
  end
end
