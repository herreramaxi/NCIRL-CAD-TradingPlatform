class CreatePmProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :pm_profiles do |t|
      t.string :investment_strategy
      t.string :ips
      t.string :pm_notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
