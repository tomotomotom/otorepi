class RecipesController < ApplicationController

  def home
  end

  def index
    @recipes = Recipe.all.order(created_at: :desc)
  end
  
  def new
    @recipe = Recipe.new
    3.times { @recipe.ingredients.build }
    3.times { @recipe.steps.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to @recipe, notice: "レシピを登録しました。"
    else
      3.times { @recipe.ingredients.build } if @recipe.ingredients.empty?
      3.times { @recipe.steps.build } if @recipe.steps.empty?
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def read
    @recipe = Recipe.find(params[:id])
    @steps = @recipe.steps.order(:number)
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title, :description,
      ingredients_attributes: [:name, :quantity],
      steps_attributes: [:number, :content]
    )
  end
end
