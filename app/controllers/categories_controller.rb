class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products

    @filter = params[:filter]
    if @filter == "on_sale"
      @products = @products.where(on_sale: true)
    elsif @filter == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif @filter == "recently_updated"
      @products = @products.where("updated_at >= ?", 3.days.ago)
    end

    @products = @products.page(params[:page]).per(9)
  end
end
