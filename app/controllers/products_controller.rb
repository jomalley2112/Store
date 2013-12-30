class ProductsController < ApplicationController
  def index
  	@products = Product.where(where_clause).order(:name).all 
  end

  
  def admin
    #All Admins must first go through this action
    @admin = true
    session[:admin] = "true" #once this is set the application_contoller handles setting the variable
    @products = Product.where(where_clause).order(:name).all
    render :index
  end

  def list_by_category
  	if cat_id = params[:id]
  		@cat = ProductCategory.find(cat_id)
  		@products = @cat.products
  	else
  		redirect_to :index
  	end 
  end
 
  def add_to_cart 
  	shopping_cart = get_or_create_cart
  	shopping_cart.add_product(Product.find(params[:product_id]))
  	redirect_to shopping_cart
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to new_product_path, :notice => "Product Saved!"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])

    if @product.update_attributes(params[:product])
      #@admin = true
      redirect_to edit_product_path(@product), :notice => "Product Updated!"
    else
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])
    #@admin = true
    @product.destroy
    redirect_to admin_products_path, :notice => 'Product Deleted!'
  end

  private
  def where_clause
    if @q = params[:txt_search]
      where_clause = "name like '%#{@q}%' or description like '%#{@q}%'"
    else
      where_clause = "1=1"
    end
  end


end
