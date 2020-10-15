class Account < ApplicationRecord
  attr_accessor :sent_transactions, :received_transactions

  validates :account_number, presence: true
  validates :bank_number, presence: true
  validates_numericality_of :balance

  belongs_to :user

  has_many :sent_transactions,
    class_name: '::Transactions',
    foreign_key: 'sender_id',
    dependent: :destroy

  has_many :received_transactions,
    class_name: '::Transactions',
    foreign_key: 'receiver_id',
    dependent: :destroy
end
