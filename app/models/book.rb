class Book < ActiveRecord::Base
  belongs_to :publisher
  has_and_belongs_to_many :authors
  has_many :cart_items
  has_many :carts, :through => :cart_items

  file_column :cover_image

  validates_length_of :title, :in => 1..255
  validates_presence_of :publisher
  validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_uniqueness_of :isbn
  validates_format_of :isbn, :with => /[0-9\-a-zA-Z]{13}/

  def self.latest
    find :all, :limit=>10, :order=>"books.id desc", :include =>[:authors, :publisher]
  end
end
