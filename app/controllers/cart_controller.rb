class CartController < ApplicationController
  before_action :get_product, only: [ :create, :destroy ]
  def create
    product_id = @product.id.to_s
    quantity = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] ||= 0
      session[:cart][product_id] += quantity
      flash[:notice] = "#{quantity} more #{@product.title} have been added to cart"
    else
      flash[:notice] = "Specify a quantity for #{@product.title}"
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
    redirect_to cart_index_path
  end

  def index
    @cart = session[:cart]
    @cart_items = []
    @cart.each do |product_id, quantity|
      product = Product.find(product_id)
      @cart_items << {
        id: product.id.to_s,
        title: product.title,
        quantity: quantity,
        description: product.description,
        image: product.image,
        price: product.price_cents
      }
    end
  end

  def get_product
    @product = Product.find(params[:product_id] || params[:id])
    @quantity = params[:quantity].to_i
  end
end
