class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: %i[ edit update destroy ]

  def index
    total = Product.count
    page_size = 5.to_f
    @pageList = [*1..(total/page_size).ceil]
    params[:page] = 1 if (params[:page].to_i < 1) || (params[:page].to_i > (total/page_size).ceil)
    @offset = (params[:page].to_i - 1) * page_size.to_i
    @products = Product.all.limit(page_size).offset(@offset)
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def edit
    @categories = Category.all
    @selectedCategories = @product.categories.map { |c| c.id.to_s  }
  end

  def create
    filtered_params = product_params
    if filtered_params.key? :categories
      category_ids = filtered_params[:categories].map { |c| c.to_i }
      filtered_params[:categories] = Category.where id: category_ids
    end
    @product = Product.new filtered_params
    if(@product.save)
      redirect_to products_url, notice: "Product was successfully created."
    else
      render :new
    end

  end

  def update
    filtered_params = product_params
    if filtered_params.key? :categories
      category_ids = filtered_params[:categories].map { |c| c.to_i }
      filtered_params[:categories] = Category.where id: category_ids
    end

    if @product.update(filtered_params)
      redirect_to products_url, notice: "Product was successfully updated."
    else
      render :edit
    end

  end

  def destroy
    @product.destroy

    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :categories => [])
    end
end
