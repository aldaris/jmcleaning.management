class AddExtraLineToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :extra_line, :string
  end
end
