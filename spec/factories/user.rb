FactoryGirl.define do
  factory :user do |f|
    # f.first_name "John"
    f.first_name { Faker::Name.first_name }
    # f.last_name "Doe"
    f.last_name { Faker::Name.last_name }
    f.email "example@me.com"
    f.password "password"

  end
end
