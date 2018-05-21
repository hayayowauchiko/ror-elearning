class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate(page: params[:page])

  end

  def new

  end

  def create
    @category = Category.new(category_params)
  end

  def destroy

  end

  def category_params
    params.require(:category).permit(:title, :description)

  end

end
