class CreateProductincomes < ActiveRecord::Migration
  def change
    create_table :productincomes do |t|
      t.string :code
      t.string :name
      t.text :description
      t.integer :quantity
      t.boolean :ingresado
      t.integer :price
      t.integer :total_price
      
      t.timestamps
    end
  end
end