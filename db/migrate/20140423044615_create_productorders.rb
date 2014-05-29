class CreateProductorders < ActiveRecord::Migration
  def change
    create_table :productorders do |t|
      t.string :code
      t.string :name
      t.text :description
      t.integer :brand_id
      t.integer :quantity
      t.boolean :ingresado
      t.integer :price
      t.integer :total_price
      t.integer :order_id
      
      t.timestamps
    end
  end
end