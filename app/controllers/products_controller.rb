class ProductsController < ApplicationController
  def index
   @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
     @product = Product.find(params[:id])
     redirect_back fallback_location: root_path
     # redirect_to product_path
     flash[:notice] = "测试加入购物车"
   end
end
