class ProductCategoriesController < ApplicationController
  def index
    @product_categories = ProductCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @product_categories }
    end
  end

  # def show
  #   @product_category = ProductCategory.find(params[:id])

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @product_category }
  #   end
  # end

  # GET /product_categories/new
  # GET /product_categories/new.json
  def new
    @product_category = ProductCategory.new
  end

  
  def edit
    @product_category = ProductCategory.find(params[:id])
  end

  def create
    @product_category = ProductCategory.new(params[:product_category])
    if @product_category.save
      redirect_to @product_category, notice: 'Product category was successfully created.'
    else
      render action: "new"
    end
  
  end

  def update
    @product_category = ProductCategory.find(params[:id])
    if @product_category.update_attributes(params[:product_category])
      redirect_to @product_category, notice: 'Product category was successfully updated.'
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
