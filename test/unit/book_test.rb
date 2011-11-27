require 'test_helper'

class BookTest < ActiveSupport::TestCase
  fixtures :authors, :publishers, :books, :authors_books

  def test_failing_create
    book = Book.new
    assert_equal false, book.save

    assert_equal 7, book.errors.size
    assert book.errors[:title].present?
    assert book.errors[:publisher].present?
    assert book.errors[:authors].present?
    assert book.errors[:published_at].present?
    assert book.errors[:isbn].present?
    assert book.errors[:page_count].present?
    assert book.errors[:price].present?
  end

  def test_create
    book = Book.new(
        :title => 'Ruby for toddlers',
        :publisher_id => Publisher.find(1).id,
        :published_at => Time.now,
        :authors => Author.find(:all),
        :isbn => '123-123-123-1',
        :blurb => "The best book for ruby",
        :page_count => 12,
        :price => 40.2
    )
    assert book.save
  end

  def test_has_many_and_belongs_to_mapping
    apress = Publisher.find(1)
    assert_equal 2, apress.books.size

    book = Book.new(
        :title => 'Rails E-Commerce 3nd Edition',
        :publisher => Publisher.find_by_name('Apress'),
        :authors => [Author.find(1), Author.find(2)],
        :published_at => Time.now,
        :isbn => '123-123-123-x',
        :blurb => 'E-Commerce on Rails',
        :page_count => 300,
        :price => 30.5
    )

    apress.books << book

    apress.reload
    book.reload

    assert_equal 3, apress.books.size
    assert_equal publishers(:apress).name, book.publisher.name
  end

  def test_has_and_belong_to_many_authors_mapping
    book = Book.new(
        :title => 'Rails E-Commerce 3nd Edition',
        :publisher => Publisher.find_by_name('Apress'),
        :authors => [Author.find(1), Author.find(2)],
        :published_at => Time.now,
        :isbn => '123-123-123-x',
        :blurb => 'E-Commerce on Rails',
        :page_count => 300,
        :price => 30.5
    )

    assert book.save

    book.reload

    assert_equal 2, book.authors.size
    assert_equal 2, Author.find(1).books.size
  end
end
