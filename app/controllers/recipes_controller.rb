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

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      redirect_to recipes_path, notice: 'レシピを削除しました'
    else
      redirect_to recipe_path(@recipe), alert: '削除に失敗しました'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "レシピを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(
      :title,
      :description,
      ingredients_attributes: [:id, :name, :quantity, :_destroy],
      steps_attributes: [:id, :number, :content, :_destroy]
    )
  end
end