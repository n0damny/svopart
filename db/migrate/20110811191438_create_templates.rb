class CreateTemplates < ActiveRecord::Migration
  def self.up
    create_table :templates do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :templates
  end
end
