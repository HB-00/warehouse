FactoryBot.define do
  factory :cargo do
    name { Faker::Name.name }
    category { Faker::Name.name }
    total_quantity { 1 }
    in_stock_quantity { 1 }
    description { "MyText" }
  end
end
