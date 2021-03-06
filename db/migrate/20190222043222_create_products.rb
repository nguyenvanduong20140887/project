class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :uniq_id
      t.string :crawl_timestamp
      t.string :product_url
      t.string :product_name
      t.string :product_category_tree
      t.string :pid
      t.decimal :retail_price
      t.decimal :discounted_price
      t.string :image
      t.string :is_FK_Advantage_product
      t.string :description
      t.float :product_rating
      t.float :overall_rating
      t.string :brand
      t.string :product_specifications

      t.timestamps
    end
  end
end
