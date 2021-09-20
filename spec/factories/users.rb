FactoryBot.define do
  factory :user do
    nickname               { Faker::Name.first_name  }
    email                  { Faker::Internet.free_email }
    password               { 'password1' }
    password_confirmation  { password }
    profile                { 'test' }
  end
end