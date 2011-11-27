require 'test_helper'

class BookTest < ActionDispatch::IntegrationTest
  fixtures :publishers, :authors

  # Replace this with your real tests.
  def test_book_administration
    publisher = Publisher.create(:name => 'Books for Dumines')
    author = Author.create(:first_name => 'Bodo', :last_name => 'Bar')

    george = new_session_as(:george)
    ruby_for_dummies = george.add_book :book =>{
        :title => 'Ruby for Dummies',
        :publisher_id => publisher.id,
        :author_ids => [author.id],
        :published_at => Time.now,
        :isbn => '120-123-103-X',
        :blurb => 'The best book released since ruby born',
        :page_count => 123,
        :price => 40
    }
    george.list_books
    george.show_book ruby_for_dummies
    george.edit_book(ruby_for_dummies, :book =>{
        :title => 'Ruby for Toddlers',
        :publisher_id => publisher.id,
        :author_ids => [author.id],
        :published_at => Time.now,
        :isbn => '123-123-123-X',
        :blurb => 'The best book released since "Eating for Toddlers"',
        :page_count => 123,
        :price => 40.4
    })

    bob = new_session_as(:bob)
    bob.delete_book ruby_for_dummies
  end

  private

  module BookTestDSL
    attr_writer :name

    def list_books
      get admin_books_path
      assert_response :success
      assert_template "admin/books/index"
    end

    def add_book(params)
      author = Author.first
      publisher = Publisher.first

      get new_admin_book_path
      assert_response :success
      assert_template "admin/books/new"

      assert_tag :tag =>'option', :attributes => {:value=>publisher.id}
      assert_tag :tag => 'select', :attributes => { :name => 'book[author_ids][]' }

      post admin_books_path, params
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_equal flash[:notice], 'Book was successfully created.'
      book = Book.find_by_title(params[:book][:title])
      assert_show_template_for(book)
      return book
    end

    def show_book(book)
      get admin_book_path(book)
      assert_response :success
      assert_show_template_for(book)
    end

    def edit_book(book, params)
      get edit_admin_book_path(book)
      assert_response :success
      assert_template "admin/books/edit"

      put admin_book_path(book), params
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_show_template_for Book.find_by_title(params[:book][:title])
    end

    def delete_book(book)
      delete admin_book_path(book)
      assert_response :redirect
      assert_redirected_to admin_books_path
      follow_redirect!
      assert_template "admin/books"
    end

    private
    def assert_show_template_for(abook)
      assert_template "admin/books/show"
      assert_equal abook.title, assigns(:book).title
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(BookTestDSL)
      session.name = name
      yield session if block_given?
    end
  end

end
