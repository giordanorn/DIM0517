class Account < ApplicationRecord
  validates :account_number, presence: true
  validates :bank_number, presence: true
  validates_numericality_of :balance

  belongs_to :user
end
