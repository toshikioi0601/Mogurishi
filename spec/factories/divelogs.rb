FactoryBot.define do
  factory :divelog do
    name { Faker::JapaneseMedia::OnePiece.location }
    description { "すばらしいダイビングポイントです" }
    depth { 10.0 }
    water_temp { 20 }
    temp { 30 }
    weather {"晴れ"}
    visibility { 15 }
    reference { "http://sample.com" }
    popularity { 5 }
    association :user
    created_at { Time.current }
  end
  
  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end
end
