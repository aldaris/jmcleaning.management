class CreateAddresses < ActiveRecord::Migration[5.2]
  def change

    create_table :clients do |t|
      t.string :name
      t.string :nick_name
      t.string :email_address
      t.string :phone_number
      t.bigint :billing_address_id
      t.timestamps
    end

    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :third_line
      t.string :town
      t.string :post_code

      t.timestamps
    end

    add_foreign_key :clients, :addresses, column: :billing_address_id
  end
end
