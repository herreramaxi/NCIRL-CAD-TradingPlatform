class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.references :administrator, foreign_key: { to_table: :users }
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.decimal :balance
      t.string :type

      t.timestamps
    end
  end
end