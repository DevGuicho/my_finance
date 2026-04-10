# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = filter_categories

    authorize @categories

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @category = Category.new

    authorize @category

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @category = current_user.categories.build(category_params)

    authorize @category

    if @category.save
      respond_to do |format|
        format.turbo_stream
        format.html do
          flash[:notice] = "Category was successfully created."
          redirect_to categories_path
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
    authorize @category
  end

  def update
    authorize @category

    if @category.update(category_params)
      respond_to do |format|
        format.html
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @category
    @category.destroy

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :kind)
  end

  def permitted_filter
    %w[all income expense].include?(params[:kind]) ? params[:kind] : "all"
  end

  def filter_categories
    categories = Category.all

    case permitted_filter
    when "income"
      categories.income
    when "expense"
      categories.expense
    else
      categories
    end
  end
end
