FactoryBot.define do
  factory :log do
    content { "水温低いから、ドライスーツがおすすめかも" }
    association :divelog
  end
end
