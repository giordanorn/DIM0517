module Accounts
  class Deposit
    def self.call(account, value)
      account.add_balance(value)
      account.add_bonus(value / 100)

      Transaction.new(
        sender_id: account.id,
        receiver_id: account.id,
        t_type: 'Deposit',
        value: value
      )
    end
  end
end
