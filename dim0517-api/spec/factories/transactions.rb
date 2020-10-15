FactoryBot.define do
  factory :transaction do
    type { 'transference' }
    value { Faker::Number.decimal(l_digits: 2) }
  end
end
