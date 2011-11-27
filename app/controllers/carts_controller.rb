class CartsController < ApplicationController
  before_filter :initialize_cart

  def add
    @book = Book.find(params[:id])

    @item = @cart.add(params[:id])
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
end
