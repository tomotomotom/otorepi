puts "🌱 Seeding database..."

Recipe.destroy_all

recipes = [
  {
    title: "簡単カレー",
    description: "市販のルーで簡単に作れる定番カレーです。",
    ingredients: [
      { name: "玉ねぎ", quantity: "1個" },
      { name: "じゃがいも", quantity: "2個" },
      { name: "カレールー", quantity: "1/2箱" }
    ],
    steps: [
      { number: 1, content: "玉ねぎとじゃがいもを切る。" },
      { number: 2, content: "野菜を炒めて水を加える。" },
      { number: 3, content: "カレールーを入れて煮込む。" }
    ]
  },
  {
    title: "たまごサンド",
    description: "ふんわり卵が美味しいサンドイッチ。",
    ingredients: [
      { name: "卵", quantity: "2個" },
      { name: "マヨネーズ", quantity: "大さじ1" },
      { name: "食パン", quantity: "2枚" }
    ],
    steps: [
      { number: 1, content: "卵を茹でてつぶす。" },
      { number: 2, content: "マヨネーズと混ぜる。" },
      { number: 3, content: "パンに挟んで切る。" }
    ]
  },
  {
    title: "だし巻き卵",
    description: "出汁の効いたふわふわ卵焼き。",
    ingredients: [
      { name: "卵", quantity: "3個" },
      { name: "だし", quantity: "50ml" },
      { name: "しょうゆ", quantity: "小さじ1" }
    ],
    steps: [
      { number: 1, content: "卵と調味料を混ぜる。" },
      { number: 2, content: "フライパンで巻きながら焼く。" },
      { number: 3, content: "形を整えて完成。" }
    ]
  }
]

recipes.each do |recipe_data|
  recipe = Recipe.create!(
    title: recipe_data[:title],
    description: recipe_data[:description]
  )

  recipe_data[:ingredients].each do |ingredient|
    recipe.ingredients.create!(ingredient)
  end

  recipe_data[:steps].each do |step|
    recipe.steps.create!(step)
  end
end

puts "✅ Seed completed!"
