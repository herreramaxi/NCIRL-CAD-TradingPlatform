class CreateTraderStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :trader_stocks do |t|
      t.references :user, null: false, foreign_key: {on_delete: :cascade }
      t.references :stock_symbol, null: false, foreign_key: true

      t.timestamps
    end
  end
end
