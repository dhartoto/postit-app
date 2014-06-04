class CategoriesController < ApplicationController
  before_action :set_catagory, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Your category has been added."
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "Your category has been updated"
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_catagory
    @category = Category.find_by(slug: params[:id])
  end
end
