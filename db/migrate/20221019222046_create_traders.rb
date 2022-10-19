class CreateTraders < ActiveRecord::Migration[7.0]
  def change
    create_table :traders do |t|
      t.string :firstName
      t.string :lastName
      t.string :emails

      t.timestamps
    end
  end
end