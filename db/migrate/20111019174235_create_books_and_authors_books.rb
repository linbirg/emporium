class CreateBooksAndAuthorsBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :title, :limit => 255,:null => false
      t.integer :publisher_id, :null => false
      t.datetime :published_at
      t.string :isbn, :limit=>13, :unique=>true
      t.text :blurb
      t.integer :page_count
      t.float :price

      t.timestamp
    end

    create_table :authors_books, :id => false do |t|
      t.integer :author_id, :null => false
      t.integer :book_id, :null => false
    end
  end

  def self.down
    drop_table :authors_books
    drop_table :books
  end
end
