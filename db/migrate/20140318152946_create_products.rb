class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :detail
      t.text :description
      t.string :code
      t.integer :brand_id
      t.string :category
      t.float :bought_price         
      t.float :sale_price     
      t.integer :quantity
      t.boolean :home
      
      t.timestamps
    end
  end
end
