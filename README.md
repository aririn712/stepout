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
[![Image from Gyazo](https://i.gyazo.com/8f5a3a4cbe2de03e1e3f9b13e76f3244.gif)](https://gyazo.com/8f5a3a4cbe2de03e1e3f9b13e76f3244)

トップページに遷移する際、ログインしていなければこちらの画面に遷移します。新規登録画面とログイン画面は行き来することができ、必要事項を入力していただくことで、トップページに遷移できます。

## トップページ (講座一覧画面)
[![Image from Gyazo](https://i.gyazo.com/baac5df5bfe568d04d1140b1ef45bf61.gif)](https://gyazo.com/baac5df5bfe568d04d1140b1ef45bf61)

本サイトのトップページです。すでに開かれている講座を、最新投稿順とカテゴリごとで一覧として見ることができます。タイトル横の検索フォームでは、簡単な検索が可能になっています。また、ログアウトやご自分のユーザーページ、開講画面にもこちらから遷移できます。これらはユーザーページ、講座詳細画面、検索結果画面でも可能です。

## 開講画面
[![Image from Gyazo](https://i.gyazo.com/d0623542b1fa568ba13f2dafb6a300b9.gif)](https://gyazo.com/d0623542b1fa568ba13f2dafb6a300b9)

トップページ等の"講座を開く"ボタンからこちらの画面に遷移し、必要事項を入力していただくことで開講できます。開講後は、ご自身のユーザーページに遷移します。

## 講座詳細画面 (開講者側)
[![Image from Gyazo](https://i.gyazo.com/6a53b389c10786f101cb0aa6745fcd5f.gif)](https://gyazo.com/6a53b389c10786f101cb0aa6745fcd5f)

ご自身の講座をクリックすることで遷移でき、開講する際に記入した内容が記述されています。また、受講希望者一覧画面、講座編集画面の方はこちらから遷移でき、講座削除も可能になっています。

## 講座編集画面
[![Image from Gyazo](https://i.gyazo.com/a67ea4557e3d63e5a81e3a03ea134a82.gif)](https://gyazo.com/a67ea4557e3d63e5a81e3a03ea134a82)

開講する際に記述した内容が保存されており、何も編集せずに保存ボタンをクリックしても元の内容が保存されます。

## 講座詳細画面 (受講者側)
[![Image from Gyazo](https://i.gyazo.com/8b0514c36dd75a4fd3d19bb3ff2ecc2c.gif)](https://gyazo.com/8b0514c36dd75a4fd3d19bb3ff2ecc2c)

講座の詳細情報が記述されており、この画面から受講希望、受講希望の却下ができます。

## ユーザーページ
[![Image from Gyazo](https://i.gyazo.com/f8b6f63f12dec907dc01e6ea1e8e55e1.gif)](https://gyazo.com/f8b6f63f12dec907dc01e6ea1e8e55e1)

トップページ等のご自身の名前や他のユーザーの名前をクリックすることで、クリックしたユーザー名のユーザーページに遷移できます。ユーザーページでは、そのユーザーが開講した講座一覧を見ることができ、そのユーザーページがご自身のページであれば、自分が受講申請している講座を見ることができたり、プロフィール編集ボタンがあります。

## プロフィール編集画面
[![Image from Gyazo](https://i.gyazo.com/ba6747514c435bd4af82d4ca005fa170.png)](https://gyazo.com/ba6747514c435bd4af82d4ca005fa170)

ご自身のユーザーページの"プロフィール編集"ボタンから遷移できます。このページでは、名前と、プロフィールを編集ができます。

## 受講希望者一覧画面
[![Image from Gyazo](https://i.gyazo.com/0c8f621d2de0711e8a411ea4e21f228b.png)](https://gyazo.com/0c8f621d2de0711e8a411ea4e21f228b)

ご自身が開講した講座の詳細ページにある"受講希望者リスト"ボタンから遷移でき、この講座を受講希望しているユーザーの名前が表示されます。

# 工夫したポイント
- 基本このアプリケーションの閲覧にはサインインが必要ですが、他のSNSアプリに自分のユーザーページのURLを貼ることが想定されるため、ユーザーページのみサインインしなくとも閲覧することができます
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


