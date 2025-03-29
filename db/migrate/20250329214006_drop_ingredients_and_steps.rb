class DropIngredientsAndSteps < ActiveRecord::Migration[6.1]
  def change
    drop_table :ingredients
    drop_table :steps
  end
end
