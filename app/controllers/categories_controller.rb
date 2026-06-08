class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    authorize! :create, Category
    @category = Category.new
  end

  def create
    authorize! :create, Category

    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! :update, @category
  end

  def update
    authorize! :update, @category

    if @category.update(category_params)
      redirect_to @category, notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @category

    @category.destroy
    redirect_to categories_path, notice: "Category deleted successfully."
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end