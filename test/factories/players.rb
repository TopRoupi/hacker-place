FactoryBot.define do
  factory :player do
    association :computer

    email { "lol@lol.com" }
    password { "123456" }
  end
end
