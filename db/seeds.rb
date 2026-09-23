require "securerandom"

sample_user = User.find_or_initialize_by(email: User::SAMPLE_EMAIL)
sample_user.nickname = "オトレピ編集部"
if sample_user.new_record?
  password = SecureRandom.base64(32)
  sample_user.password = password
  sample_user.password_confirmation = password
end
sample_user.save!

sample_recipes = [
  {
    title: "10分でふわとろ親子丼",
    description: "やさしい甘辛味と半熟卵がうれしい、忙しい日の定番どんぶりです。",
    materials_text: <<~TEXT.strip,
      鶏もも肉 150g
      玉ねぎ 1/4個
      卵 2個
      ごはん 1杯分
      めんつゆ（2倍濃縮） 大さじ2
      水 大さじ4
      砂糖 小さじ1
    TEXT
    steps_text: <<~TEXT.strip
      鶏もも肉はひと口大に、玉ねぎは薄切りにする。
      小さめのフライパンにめんつゆ、水、砂糖、玉ねぎを入れて中火にかける。
      玉ねぎが透き通ったら鶏肉を加え、火が通るまで4分ほど煮る。
      溶き卵を2回に分けて回し入れ、好みの固さで火を止める。
      ごはんに盛りつけて完成。
    TEXT
  },
  {
    title: "野菜たっぷりミネストローネ",
    description: "冷蔵庫の野菜をおいしく使い切れる、ほっと温まる具だくさんスープです。",
    materials_text: <<~TEXT.strip,
      玉ねぎ 1/2個
      にんじん 1/2本
      キャベツ 2枚
      カットトマト缶 200g
      水 300ml
      コンソメ 小さじ2
      オリーブオイル 小さじ1
      塩・こしょう 少々
    TEXT
    steps_text: <<~TEXT.strip
      玉ねぎ、にんじん、キャベツを1センチ角に切る。
      鍋にオリーブオイルを入れ、野菜を中火で3分ほど炒める。
      トマト缶、水、コンソメを加え、沸騰したら弱火にする。
      ふたをして15分煮込み、塩とこしょうで味を調える。
    TEXT
  },
  {
    title: "鮭ときのこのバター醤油ホイル焼き",
    description: "包んで焼くだけ。鮭ときのこのうま味を逃さない、後片付けも簡単な一品です。",
    materials_text: <<~TEXT.strip,
      生鮭 1切れ
      しめじ 1/3パック
      玉ねぎ 1/4個
      バター 10g
      醤油 小さじ1
      酒 小さじ1
      塩・こしょう 少々
    TEXT
    steps_text: <<~TEXT.strip
      鮭に塩とこしょうを振り、玉ねぎは薄切り、しめじは小房に分ける。
      アルミホイルに玉ねぎ、鮭、しめじの順にのせる。
      酒、醤油、バターを加え、蒸気が逃げないように包む。
      フライパンに並べて水を1センチほど注ぎ、ふたをして中火で15分蒸し焼きにする。
    TEXT
  }
]

sample_recipes.each do |attributes|
  recipe = Recipe.find_or_initialize_by(user: sample_user, title: attributes[:title])
  recipe.assign_attributes(attributes)
  recipe.save!
end

puts "サンプルレシピを#{sample_recipes.size}件用意しました。"
