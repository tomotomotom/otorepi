class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_recipe, only: %i[show read edit update destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def home
    @sample_recipes = Recipe.samples.includes(:user).order(:id).limit(3)
  end

  def index
    @recipes = Recipe.includes(:user).order(created_at: :desc)
  end
  
  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "レシピを登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def read
  end

  def destroy
    if @recipe.destroy
      redirect_to recipes_path, notice: 'レシピを削除しました'
    else
      redirect_to recipe_path(@recipe), alert: '削除に失敗しました'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "レシピを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(
      :title,
      :description,
      :materials_text,
      :steps_text
    )
  end

  def correct_user
    return if @recipe.user == current_user

    redirect_to recipes_path, alert: "他のユーザーのレシピは編集できません。"
  end
end
