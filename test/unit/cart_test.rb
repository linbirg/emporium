require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :authors, :publishers, :books

  # Replace this with your real tests.
  def test_total
    assert true
  end

  def test_add
    cart = Cart.create
    assert cart
    item = cart.add(books(:pro_rails_ecommerce).id)
    assert item
    assert_equal item.book.title, books(:pro_rails_ecommerce).title
  end

#  NON_EXIST_BOOK_ID = 9999
#  def test_add_with_non_exist_book_id
#    cart = Cart.create
#    assert_equal false, Book.exists?(NON_EXIST_BOOK_ID)
#    item = cart.add(NON_EXIST_BOOK_ID)
#    assert item
#    assert_equal nil, item.book
#  end
end
