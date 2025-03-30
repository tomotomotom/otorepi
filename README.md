# 🍳 オトレピ - レシピ読み上げアプリ

![Ruby](https://img.shields.io/badge/Ruby-3.2.2-red)
![Rails](https://img.shields.io/badge/Rails-6.1.7.3-red)
![License](https://img.shields.io/badge/License-MIT-brightgreen)
![Made with](https://img.shields.io/badge/Made%20with-SpeechSynthesis%20API-blue)

---

## 📖 概要

このアプリは、料理中に手がふさがっていてもスマホを操作せずにレシピを確認できる「読み上げ対応レシピアプリ」です。

ユーザーは自分でレシピを登録し、音声でステップごとの手順を読み上げてもらうことができます。  
**「見る」から「聴く」へ。料理体験をもっとスムーズに！**

---

## ✨ 機能（MVP）

- レシピの登録（タイトル・材料・手順）
- 手順をステップごとに登録
- 登録済みレシピの一覧・詳細表示
- ステップごとに音声でレシピを読み上げる（ブラウザの音声合成機能を使用）

---

## 🛠 使用技術

- **フレームワーク**：Ruby on Rails
- **言語**：Ruby / HTML / CSS / JavaScript
- **データベース**：SQLite（開発環境）
- **音声読み上げ**：`SpeechSynthesis API`（ブラウザ組み込み）

---

## ⚙️ セットアップ方法（開発環境）

```bash
git clone https://github.com/tomotomotom/otorepi.git
cd otorepi
bundle install
rails db:create db:migrate
rails server

## 🗂 データベース設計

### 🥘 recipes テーブル（レシピ本体）

| カラム名       | 型       | 説明                                       |
|----------------|----------|--------------------------------------------|
| id             | integer  | 主キー                                     |
| title          | string   | レシピタイトル                             |
| description    | text     | レシピの補足説明（任意）                   |
| materials_text | text     | 材料をまとめて記述（複数行テキスト）       |
| steps_text     | text     | 手順をまとめて記述（複数行テキスト）       |
| created_at     | datetime | 作成日時                                   |
| updated_at     | datetime | 更新日時                                   |

📝 **補足**：
- `materials_text` には改行区切りで材料を記述（例：「卵 2個」「牛乳 100ml」など）
- `steps_text` には調理工程をステップごとに記述（例：「卵をよく混ぜる」「フライパンに流す」など）
- 本構成によりフォームがシンプルかつ自由度の高い UI になります

🔮 今後の予定（発展機能）
音声操作（「次へ」「戻る」「ストップ」など）

Amazon Polly等を使った高品質音声読み上げ

レシピのお気に入り機能

レシピの共有（他ユーザーと使える機能）

ユーザー登録・ログイン機能（任意）

📄 ライセンス
MIT License

---
