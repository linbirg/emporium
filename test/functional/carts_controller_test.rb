require 'test_helper'

class CartsControllerTest < ActionController::TestCase
  fixtures :authors, :publishers, :books
  # Replace this with your real tests.
  def setup
    @controller = CartsController.new
    @request = ActionController::TestRequest.new
    @response = ActionController::TestResponse.new
  end

  #def test_adding
  #  assert_difference(CartItem, :count) do
  #    post :add, :id => books(:pro_rails_ecommerce).id
  #  end
  #
  #  assert_equal flash[:cart_notice],"Added <em>#{books(:pro_rails_ecommerce).title}</em>"
  #  assert_response :redirect
  #  assert_redirected_to '/catalog'
  #  assert_equal @request.session[:cart_id], assigns(:cart).id
  #  assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  #end
  #
  #def test_adding_with_xhr
  #  assert_difference(CartItem, :count) do
  #    xhr :post, :add, :id => books(:pro_rails_ecommerce).id
  #  end
  #  assert_response :success
  #  assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  #end
end
