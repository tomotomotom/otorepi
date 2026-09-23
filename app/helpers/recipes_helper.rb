module RecipesHelper
  def recipe_emoji(recipe)
    case recipe.title
    when /丼|ごはん|米/
      "🍚"
    when /スープ|ミネストローネ|汁/
      "🥣"
    when /鮭|魚|さば/
      "🐟"
    when /鶏|チキン/
      "🍗"
    else
      "🍽️"
    end
  end
end
