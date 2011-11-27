class CartItemsController < ApplicationController
  #before_filter :initialize_cart
  # GET /cart_items
  # GET /cart_items.xml
  def index
    @cart_items = CartItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cart_items }
    end
  end

  # GET /cart_items/1
  # GET /cart_items/1.xml
  def show
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart_item }
    end
  end

  # GET /cart_items/new
  # GET /cart_items/new.xml
  def new
#    @cart_item = CartItem.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @cart_item }
#    end
    @book = Book.find(params[:book_id])
  end

  # GET /cart_items/1/edit
  def edit
    @cart_item = CartItem.find(params[:id])
  end

  # POST /cart_items
  # POST /cart_items.xml
  def create
    @cart = current_cart
    book = Book.find(params[:book_id])

    @item = @cart.add(book.id)
    if request.xhr?
      flash.now[:cart_notice] = "Added <em>#{@item.book.title}</em>".html_safe
      render  :action => "add_with_ajax"
    elsif request.post?
      flash[:cart_notice] = "Added <em>#{@item.book.title}</em>".html_safe
      redirect_to session[:return_to] || "/catalog"
    else
      render
    end
  end

  # PUT /cart_items/1
  # PUT /cart_items/1.xml
  def update
    @cart_item = CartItem.find(params[:id])

    respond_to do |format|
      if @cart_item.update_attributes(params[:cart_item])
        format.html { redirect_to(@cart_item, :notice => 'Cart item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cart_items/1
  # DELETE /cart_items/1.xml
  def destroy
    @cart = current_cart
    @item = CartItem.find(params[:id])
    @book = @item.book
    if @item.amount > 1
      @item.update_attribute(:amount, @item.amount - 1)
    else
      CartItem.destroy(@item)
    end

    if request.xhr?
      flash.now[:cart_notice] = "Remove 1 <em>#{@item.book.title}</em>".html_safe
      render :action => "remove_with_ajax"
    elsif request.delete?
      flash[:cart_notice] = "Remove 1 <em>#{@item.book.title}</em>".html_safe
      redirect_to(session[:return_to] || "/catalog")
    end
  end
end
