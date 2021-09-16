# StepOut

# アプリケーションの概要
### 自分で作ったオンライン学習講座を共有できる、掲示板サイトです。

# 本番環境
### https://stepout-35495.herokuapp.com/
### ログイン情報(テスト用)
- Eメール : test@gmail.com
- パスワード : test1234 

# 制作背景(意図)
 若年層や、SNSを始めたばかりの人、フォロワーが少ない人で、教える技術があるのにもかかわらず、そのことを世間に発信する専門の媒体がほぼ無いことからこのアプリを作成しました。  
 このアプリの中で講座を開くことで、学びたいことからその人を見つけることが可能になり、また値段の交渉や、実際に学べる内容の確認などの手間を省くことができるようになります。

# DEMO

# 工夫したポイント
- 基本このアプリケーションの閲覧にはサインインが必要だが、他のSNSアプリに自分のユーザーページのURLを貼ることが想定されるため、ユーザーページのみサインインしなくとも閲覧することができます
- カテゴリに分けることで、受けたい講座を調べやすくしました
- プロフィールを作ることで他のSNSアプリのURLを貼れるようにしました
- 決済機能をこのアプリ自体に入れないことで決済手段の自由性を高めました

# 使用技術開発環境
## バックエンド
Ruby, Ruby on Rails
## フロントエンド
HTML, CSS, SCSS, JavaScript
## データベース
MySQL SequelPro
## インフラ
AWS(S3)
## Webサーバ
Heroku
## ソース管理
GitHub, GitHubDesktop
## テスト
Rspec
## エディタ
VSCode

# 課題や今後実装したい機能
- 個人間のチャット機能 (現状、連絡手段が他のSNSアプリに依存してしまっているため)
- 通知機能 (開講者が受講申請に気付きやすくするため)
- デバイスごとのレイアウト変更 (主にスマートフォンでの利用が多くなると予測されるため)

# DB設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| profile            | text    |                           |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |


### Association

- has_many :orders
- has_many :courses
- has_many :ord_courses, through: :orders, source: :course

## courses テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| title         | string     | null: false       |
| category_id   | integer    | null: false       |
| text_1        | text       | null: false       |
| text_2        | text       |                   |
| text_3        | text       |                   |
| text_4        | text       |                   |
| hour_id       | integer    | null: false       |
| machine_id    | integer    | null: false       |
| other_machine | string     |                   |
| time_zone_id  | integer    | null: false       |
| price         | integer    | null: false       |
| user          | references | foreign_key: true |

### Association

- has_many :orders
- belongs_to :user

## orders テーブル

| Column     | Type       | Options           |
| ---------- | ---------- | ----------------- |
| course     | references | foreign_key: true |
| user       | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :course


