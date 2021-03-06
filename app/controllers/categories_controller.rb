class CategoriesController < ApplicationController

  before_action :set_category, only: %i[ show edit ]
  before_action :require_admin, except: %i[ index show ]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def show
    @articles = @category.articles.all
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully."
      redirect_to @category
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(category_params)
    if @category.update(category_params)
      flash[:notice] = "Category name was updated successfully."
      redirect_to @category
    else
      render "edit", status: :unprocessable_entity
    end
  end



  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform that action"
      redirect_to articles_path
    end
  end
end
