class CartController < ApplicationController
  before_action :get_product, only: [ :create, :destroy ]
  def create
    product_id = @product.id.to_s
    if session[:cart][product_id]
      session[:cart][product_id] += 1
      flash[:notice] = "#{@product.title} quantity updated in cart"
    else
      session[:cart][product_id] = 1
      flash[:notice] = "#{@product.title} added to cart"
    end
    redirect_to product_path(@product)
  end

  def destroy
    product_id = @product.id.to_s
    if session[:cart][product_id]
      session[:cart].delete(product_id)
      flash[:notice] = "#{@product.title} removed from cart"
    else
      flash[:alert] = "Product not found in your cart"
    end
  end

  def get_product
    @product = Product.find(params[:product_id])
  end
end
