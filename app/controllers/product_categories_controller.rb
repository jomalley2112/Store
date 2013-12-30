class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all
  end

  
  def new
    @product_category = ProductCategory.new
  end

  
  def edit
    @product_category = ProductCategory.find(params[:id])
  end

  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      redirect_to product_categories_url, notice: 'Category was created!'
    else
      render action: "new"
    end
  
  end

  def update
    @product_category = ProductCategory.find(params[:id])
    if @product_category.update_attributes(params[:product_category])
      redirect_to product_categories_url, notice: 'Category was updated!'
    else
      render action: "edit"
    end
  end

  def destroy
    @product_category = ProductCategory.find(params[:id])
    @product_category.destroy
    redirect_to product_categories_url
  end
end
