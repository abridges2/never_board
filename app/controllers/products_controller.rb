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
    @products = Product.all

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
    # @latest_products = Product.order(created_at: :desc).limit(5)
    # @popular_products = Product.order(purchases_count: :desc).limit(5)
    # @discounted_products = Product.where("discount > 0").limit(5)
    @on_sale_products = Product.where("sale_price < price").limit(5)
    # @new_arrivals = Product.order(created_at: :desc).limit(5)
    # @top_rated_products = Product.where("rating >= ?", 4).limit(5)
    # @best_selling_products = Product.order(sales_count: :desc).limit(5)
    # @trending_products = Product.where("trending = ?", true).limit(5)
    # @seasonal_products = Product.where("seasonal = ?", true).limit(5)
    # @limited_edition_products = Product.where("limited_edition = ?", true).limit(5)
    # @clearance_products = Product.where("clearance = ?", true).limit(5)
    # @eco_friendly_products = Product.where("eco_friendly = ?", true).limit(5)
    # @handmade_products = Product.where("handmade = ?", true).limit(5)
    # @locally_sourced_products = Product.where("locally_sourced = ?", true).limit(5)
    # @artisan_products = Product.where("artisan = ?", true).limit(5)
    # @customizable_products = Product.where("customizable = ?", true).limit(5)
  end
end
