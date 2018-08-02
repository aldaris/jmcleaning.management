class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :nick_name
      t.string :email_address
      t.string :phone_number
      t.string :add_foreign_key
      t.addresses :

      t.timestamps
    end
  end
end
