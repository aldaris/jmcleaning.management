class CreateDb < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :nick_name
      t.string :email_address
      t.string :phone_number
      t.timestamps
    end

    create_table :addresses do |t|
      t.belongs_to :client
      t.string :first_line
      t.string :second_line
      t.string :third_line
      t.string :town
      t.string :post_code
      t.timestamps
    end

    add_foreign_key :addresses, :clients

    create_table :prices do |t|
      t.string :description
      t.decimal :amount
      t.boolean :is_active
      t.boolean :is_visible
      t.timestamps
    end

    create_table :invoice_items do |t|
      t.belongs_to :price
      t.decimal :quantity
      t.timestamps
    end

    add_foreign_key :invoice_items, :prices

    create_table :invoices do |t|
      t.date :issue_date
      t.belongs_to :client
      t.date :due_date
      t.binary :pdf
      t.boolean :is_draft
      t.timestamps
    end

    add_foreign_key :invoices, :clients

    change_table :invoice_items do |t|
      t.belongs_to :invoice
    end

    add_foreign_key :invoice_items, :invoices
  end
end
