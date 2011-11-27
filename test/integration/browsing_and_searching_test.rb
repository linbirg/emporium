require 'test_helper'

class BrowsingAndSearchingTest < ActionDispatch::IntegrationTest
  fixtures :publishers, :authors, :books

  # Replace this with your real tests.
  def test_browsing_the_site
    jill = enter_site(:jill)
    jill.browse_index
    jill.view_latest_books
    jill.add_book_to_cart
  end

  def test_getting_details
    jill = enter_site(:jill)
    jill.get_book_detail_for(books(:pro_rails_ecommerce_9).title)
  end

  private
  module BrowsingTestDSL
    attr_writer :name

    def browse_index
      get 'catalog'

      assert_response :success
      assert_template "catalog/index"
      check_book_link
    end

    # define the per page for book paginate.
    PER_PAGE = 2
    def go_to_second_page
      get 'catalog',:page => 2  #/catalog/index?page=2"
      assert_response :success
      assert_template "catalog/index"
      check_book_link

      @books_db = Book.paginate :page => 2,
                             :per_page => PER_PAGE,
                             :include => [:authors, :publisher],
                             :order => "books.id desc"
      assert_equal @books_db.last, assign(:books).last
    end

    def get_book_detail_for(title)
      book = Book.find_by_title(title)
      get "catalog/#{book.id}"

      assert_response :success
      assert_template "catalog/show"

      assert_equal title, assigns(:book).title
    end

    def view_latest_books
#       get "catalog/latest"
#       assert_response :success
#      assert_tempalte "catalog/latest"
#      assert_latest_template
    end

    def add_book_to_cart
      browse_index
      cart_id = assigns(:cart).id
      assert_equal false, cart_id.nil?
      book = assigns(:books).first
      assert_difference(CartItem, :count) do
        xhr :post, cart_items_path(:book_id => book)
      end

      assert_equal flash[:cart_notice],"Added <em>#{book.title}</em>"
      #assert_response :redirect
      #assert_redirected_to '/catalog'
      assert_equal cart_id, assigns(:cart).id
    end

    private
    def check_book_link
      for book in assigns(:books)
        assert_tag :tag=>'a', :attributes => {:href => "/catalog/#{book.id}"}
      end
    end

    def assert_latest_template
#      assert_equal "Latest Books", assigns(:page_title)
#      assert_tag :tag=>'img',
#                 :attributes => {:src => url_for_file_column(assigns(:books).first, :cover_image)}
    end

  end

  def enter_site(name)
    open_session do |session|
      session.extend(BrowsingTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
