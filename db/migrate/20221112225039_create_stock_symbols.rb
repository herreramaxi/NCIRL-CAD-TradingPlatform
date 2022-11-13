class CreateStockSymbols < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_symbols do |t|
      t.string :symbol
      t.string :name
      t.integer :ipo_year
      t.string :country
      t.string :sector
      t.string :industry

      t.timestamps
    end
  end
end
