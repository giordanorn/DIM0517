require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:sender) }
  it { should belong_to(:receiver) }

  it { should validate_numericality_of(:value) }
end
