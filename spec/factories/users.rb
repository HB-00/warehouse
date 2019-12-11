FactoryBot.define do
  factory :user do
    name { "MyString" }
    password_digest { "MyString" }
    role { 1 }
  end
end
