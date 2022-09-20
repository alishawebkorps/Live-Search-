class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :distt
      t.string :city
      t.string :street
      t.string :house_no
      t.integer :pin_code
      t.references :user
      t.timestamps
    end
  end
end
