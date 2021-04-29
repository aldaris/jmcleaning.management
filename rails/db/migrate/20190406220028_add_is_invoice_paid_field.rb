class AddIsInvoicePaidField < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :is_invoice_paid, :boolean
  end
end
