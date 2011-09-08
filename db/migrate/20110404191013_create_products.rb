class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.string :producer
      t.string :model
      t.string :print_tech
      t.string :color
      t.string :compatibility
      t.string :capacity
      t.decimal :weight
      t.text :description
      t.decimal :price
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
