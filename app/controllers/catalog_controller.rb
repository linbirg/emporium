require 'net/http'

class CatalogController < ApplicationController
  before_filter :initialize_cart

  def index
    @page_title = "Book List"
    @books = Book.paginate :page => params[:page], :per_page => 2, :include => [:authors, :publisher], :order => "books.id desc"
  end

  def show
    @book = Book.find(params[:id])
    return render(:text=>"Not found", :status => 404) unless @book
    @page_title = @book.title
  end

  def search
  end

  def latest
    @books = Book.paginate :page => params[:page], :per_page => 1
    @page_title = "Latest Books"
  end

  def brief
    test_tb
    @books = Book.paginate :page => params[:page], :per_page => 1
  end

  private
  def test_tb
     url = URI.parse('http://gw.api.taobao.com/router/rest')
     params = {
         'app_key' => '12407395',
         'app_secret' => '03eb8de1e23ff3d070efe62a2d0e9bea',
         'method' => 'taobao.items.get',
         'timestamp' => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
         'format' => 'json',
         'v' => '2.0',
         'q' => 'E71',
         'fields' => 'iid,title,pic_url,price'
     }
     params["sign"] = Digest::MD5.hexdigest('03eb8de1e23ff3d070efe62a2d0e9bea' + params.sort.flatten.join).upcase
     resp  = Net::HTTP.post_form(url, params)
     @result = JSON.parse(resp.body)
     @items = @result["items_get_response"]
     @item = @items["items"].first
     @one_c = @item[1]
     @count = @one_c.length
     @index = rand @one_c.length
     @img_path = @one_c[@index]["pic_url"]
  end

end
