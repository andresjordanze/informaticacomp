class CreateProductsales < ActiveRecord::Migration
  def change
    create_table :productsales do |t|
    	t.string :name
    	t.string :code
    	t.string :description
    	t.string :brand
      t.string :price

      t.timestamps
    end
  end
end