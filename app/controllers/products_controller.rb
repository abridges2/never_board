class ProductsController < ApplicationController
  def index
    @products = Product.all.page(params[:page]).per(9)
    @filter = params[:filter]

    if params[:filter] == "on_sale"
      @products = @products.where(on_sale: true)
    end
    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    end
    if params[:filter] == "recently_updated"
      @products = @products.where("updated_at >= ?", 3.days.ago)
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @query = params[:query]
    @category_id = params[:category_id]
    @products = Product.all.page(params[:page]).per(9)

    if params[:query].present?
      @products = @products.where("title LIKE ? OR description LIKE ?", "%#{@query}%", "%#{@query}%")
    end

    if params[:category_id].present?
      @products = @products.where("category_id = ?", @category_id)
    end

    render :index
  end

  def home
    @products = Product.all
    @categories = Category.all
    @featured_products = Product.where(featured: true).limit(5)
    @random_products = Product.order("RANDOM()").limit(3)
    @on_sale_products = Product.where("sale_price < price").limit(5)
  end
end
