FactoryBot.define do
  factory :account do
    account_number { Faker::Bank.account_number }
    bank_number { Faker::Bank.routing_number }
    balance { Faker::Number.decimal(l_digits: 2) }
    bonus_balance { Faker::Number.decimal(l_digits: 2) }
    user
  end
end
