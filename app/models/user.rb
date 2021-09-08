class User < ApplicationRecord
  has_many :courses
  has_many :orders
  has_many :ord_courses, through: :orders, source: :course

  def like(course)
    orders.find_or_create_by(course_id: course.id)
  end

  def unlike(course)
    order = orders.find_by(course_id: course.id)
    order.destroy if order
  end

  def like?(course)
    ord_courses.include?(course)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'
end
