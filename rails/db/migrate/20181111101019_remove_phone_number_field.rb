class RemovePhoneNumberField < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :phone_number, :string
  end
end
