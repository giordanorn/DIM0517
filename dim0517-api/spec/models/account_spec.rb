require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should validate_presence_of(:account_number) }
  it { should validate_presence_of(:bank_number) }
  it { should validate_numericality_of(:balance) }
  it { should validate_numericality_of(:bonus_balance) }
end
