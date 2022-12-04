class CreateTraderProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :trader_profiles do |t|
      t.string :preferred_index1
      t.string :preferred_index2
      t.string :preferred_index3
      t.string :trader_notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
