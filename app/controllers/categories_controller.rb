class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    total = Category.count
    page_size = 5.to_f
    @pageList = [*1..(total/page_size).ceil]
    params[:page] = 1 if (params[:page].to_i < 1) || (params[:page].to_i > (total/page_size).ceil)
    @offset = (params[:page].to_i - 1) * page_size.to_i
    @categories = Category.all.limit(page_size).offset(@offset)
  end

  def new
    @categories = Category.all
  end

  def create
    payloads = create_category_params
    title = "Undefined"
    isSuccess = false
    if(payloads[:parent_category].empty?)
      title = "Category"
      @category = Category.new()
      @category.name = payloads[:name]
      isSuccess = @category.save
    else
      title = "SubCategory"
      @category = Category.find payloads[:parent_category].to_i
      @sub_categories = SubCategory.new
      @sub_categories.name = payloads[:name]
      @sub_categories.category = @category
      isSuccess = @sub_categories.save
    end

    if isSuccess
      redirect_to categories_url(), notice: "#{title} was successfully created."
    else
      render :new
    end

  end



  private
    def create_category_params
      params.require(:name)
      params.permit(:name, :parent_category)
    end
end
