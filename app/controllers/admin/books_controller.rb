class Admin::BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  def index
    #@books = Book.all

    #@page_title = 'Listing books'
    sort_by = params[:sort_by]
    @books = Book.paginate :page => params[:page], :order => sort_by, :per_page => 2

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])
    @page_title = "#{@book.title}"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    book = Book.first
    @book.authors = book.authors
    @book.blurb = book.blurb
    @book.isbn = "100-#{rand 9 }#{rand 9}#{rand 9}-100-#{rand 9}"
    @book.page_count = book.page_count
    @book.price = book.price
    @book.title = book.title
    @book.published_at = book.published_at
    @book.publisher = book.publisher
    load_data

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @page_title = 'Editing book'
    load_data
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to([:admin,@book], :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        load_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to([:admin,@book], :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        load_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(admin_books_url) }
      format.xml  { head :ok }
    end
  end

  private
  def load_data
      @authors = Author.find(:all)
      @publishers = Publisher.find(:all)
  end
end
