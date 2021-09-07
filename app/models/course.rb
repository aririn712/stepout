class Course < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions 
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :hour
  belongs_to :machine
  belongs_to :time_zone

  with_options presence: true do
    validates :title
    validates :text_1
  end
  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :hour_id
    validates :machine_id
    validates :time_zone_id
  end
  validates :price, presence: true, format: { with: /\A[0-9]+\z/, allow_blank: true },
                    numericality: {
                      allow_blank: true,
                      only_integer: true,
                      greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999
                    }
end