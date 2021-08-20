# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |


### Association

- has_many :order_users
- has_many :courses

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

### Association

- belongs_to :course

## order_users テーブル

| Column        | Type       | Options           |
| ------------- | ---------- | ----------------- |
| user          | references | foreign_key: true |
| order         | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order
