class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :first_line
      t.string :second_line
      t.string :third_line
      t.string :town
      t.string :postCode

      t.timestamps
    end
  end
end
