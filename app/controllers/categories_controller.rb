# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = filter_categories

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end


  def new
    @category = Category.new

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def create
    @category = current_user.categories.build(category_params)

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

  private

  def category_params
    params.require(:category).permit(:name, :kind)
  end

  def permitted_filter
    %w[all income expense].include?(params[:kind]) ? params[:kind] : "all"
  end

  def filter_categories
    categories = current_user.categories

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
