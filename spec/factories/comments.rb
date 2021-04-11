FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "ここで潜ってみたいです！" }
    association :divelog
  end
end