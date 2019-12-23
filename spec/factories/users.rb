FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number: 10) }

    factory :admin do
      role { 1 }
    end

    factory :employee do
      role { 0 }
    end
  end
end
