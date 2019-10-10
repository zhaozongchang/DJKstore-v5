class ProductsController < ApplicationController
  before_action :validate_search_key, only: [:search]

  def index
   @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
    current_cart.add_product_to_cart(@product)
    flash[:notice] = "你已成功将#{@product.title}加入购物车"
  else
    flash[:warning] = "你的购物车中已有此商品"
  end
    redirect_back fallback_location: root_path
  end

  def search
    if @query_string.present?
      search_result = Product.ransack(@search_criteria).result(:distinct => true)
      @products = search_result
    end
  end

  protected  # 放在最后


  def validate_search_key
   @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
   @search_criteria = search_criteria(@query_string)
 end

 def search_criteria(query_string)
   { :title_cont => query_string }
 end
end
