class AddPasswordDigestToTraders < ActiveRecord::Migration[7.0]
  def change
    add_column :traders, :password_digest, :string
  end
end
