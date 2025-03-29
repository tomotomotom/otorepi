# レシピの作成
recipe = Recipe.create!(
  title: "鶏むね肉でひと口ステーキ（ガリバタオニオンソース）",
  description: "鶏むね肉を使ったジューシーなステーキ風おかず。にんにくと玉ねぎの香りでご飯が進む！"
)

# 材料の登録
ingredients = [
  ["鶏むね肉", "600g"],
  ["A 酒", "大さじ1"],
  ["A 醤油", "大さじ1/2"],
  ["片栗粉", "大さじ4"],
  ["サラダ油", "大さじ2"],
  ["B 玉ねぎみじん切り", "1/2個（小サイズ）"],
  ["B 醤油", "大さじ3"],
  ["B みりん", "大さじ1"],
  ["B 酒", "大さじ1"],
  ["B 砂糖", "大さじ1"],
  ["B 酢", "大さじ1"],
  ["B にんにくチューブ", "3cm"],
  ["B バター", "15g"]
]

ingredients.each do |name, quantity|
  recipe.ingredients.create!(name: name, quantity: quantity)
end

# 手順の登録
steps = [
  "鶏むね肉はひと口大に切り、ポリ袋に入れて A を揉み込む。片栗粉をまぶす。B の調味料は混ぜ合わせておく。",
  "フライパンにサラダ油大さじ2を入れて中火で熱し、鶏むね肉を焼く。",
  "焼き色がついたら裏返して蓋をし、弱めの中火で3分ほど加熱する。",
  "余分な油を拭き取り、B を入れて少し煮詰めて完成。お好みでブラックペッパーをかけても◎"
]

steps.each_with_index do |content, index|
  recipe.steps.create!(number: index + 1, content: content)
end
