class AddMaterialsAndStepsToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :materials_text, :text
    add_column :recipes, :steps_text, :text
  end
end
