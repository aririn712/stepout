# アプリ名 - StepOut

# アプリケーションの概要
自分で作ったオンライン学習講座を共有できる、掲示板サイトです。

# 本番環境
### https://stepout-35495.herokuapp.com/
### ログイン情報(テスト用)
- Eメール : test@gmail.com
- パスワード : test1234 

# 制作背景(意図)
 若年層や、SNSを始めたばかりの人、フォロワーが少ない人で、教える技術があるのにもかかわらず、そのことを世間に発信する専門の媒体がほぼ無いことからこのアプリを作成しました。  
 このアプリの中で講座を開くことで、学びたいことからその人を見つけることが可能になり、また値段の交渉や、実際に学べる内容の確認などの手間を省くことができるようになります。

# DEMO
## 新規登録画面
[![Image from Gyazo](https://i.gyazo.com/e9ff157967d63dcc8b841ea7324cc877.gif)](https://gyazo.com/e9ff157967d63dcc8b841ea7324cc877)

## トップページ (講座一覧画面)
[![Image from Gyazo](https://i.gyazo.com/b8c82632f1222aef9ca476bcc27faa06.jpg)](https://gyazo.com/b8c82632f1222aef9ca476bcc27faa06)

## 開講画面
[![Image from Gyazo](https://i.gyazo.com/d0623542b1fa568ba13f2dafb6a300b9.gif)](https://gyazo.com/d0623542b1fa568ba13f2dafb6a300b9)

## 講座詳細画面 (開講者側)
[![Image from Gyazo](https://i.gyazo.com/6a53b389c10786f101cb0aa6745fcd5f.gif)](https://gyazo.com/6a53b389c10786f101cb0aa6745fcd5f)

## 講座詳細画面 (受講者側)
[![Image from Gyazo](https://i.gyazo.com/8b0514c36dd75a4fd3d19bb3ff2ecc2c.gif)](https://gyazo.com/8b0514c36dd75a4fd3d19bb3ff2ecc2c)

## ユーザーページ
[![Image from Gyazo](https://i.gyazo.com/f8b6f63f12dec907dc01e6ea1e8e55e1.gif)](https://gyazo.com/f8b6f63f12dec907dc01e6ea1e8e55e1)

## プロフィール編集画面
[![Image from Gyazo](https://i.gyazo.com/ba6747514c435bd4af82d4ca005fa170.png)](https://gyazo.com/ba6747514c435bd4af82d4ca005fa170)

## 受講希望者一覧画面

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


