FactoryBot.define do
  factory :favorite do
    association :divelog
    association :user
  end
end
