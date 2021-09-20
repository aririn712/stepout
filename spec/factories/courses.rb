FactoryBot.define do
  factory :course do
    title { Faker::Name.name }
    text_1  { Faker::Lorem.sentence }
    text_2  { Faker::Lorem.sentence }
    text_3  { Faker::Lorem.sentence }
    text_4  { Faker::Lorem.sentence }
    category_id    { 2 }
    hour_id        { 2 }
    machine_id     { 2 }
    other_machine  { 'test' }
    time_zone_id   { 2 }
    price          { Faker::Number.between(from: 100, to: 99_999) }
    association :user
  end
end
