class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @query = params[:query]
    @category_id = params[:category_id]
    @products = Product.all

    if params[:query].present?
      @products = @products.where("title LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
    end

    if params[:category_id].present?
      @products = @products.where("category_id = ?", @category_id)
    end

    render :index
  end
end
