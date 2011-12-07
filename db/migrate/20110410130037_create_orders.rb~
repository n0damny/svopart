class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :order_num
      t.string :name
      t.text :address
      t.string :email
      t.string :pay_type
      t.string :status, :default => 'в обработке'
      t.integer :user_id
      t.string :deliv_type
      t.integer :delivery
      t.string :advance_info
      t.string  :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
