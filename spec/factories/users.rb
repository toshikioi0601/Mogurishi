FactoryBot.define do

  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "example#{n}@example.com" }
    password { "foobar" }
    password_confirmation { "foobar" }
    introduction { "はじめまして。ダイビング初心者ですが、頑張ります！" }
    sex { "男性" }
  end
end