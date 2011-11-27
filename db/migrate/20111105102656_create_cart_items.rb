class CreateCartItems < ActiveRecord::Migration
  def self.up
    create_table :cart_items do |t|
      t.integer :book_id, :null => false
      t.integer :cart_id, :null => false
      t.float :price,:null => false
      t.integer :amount,:null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :cart_items
  end
end
