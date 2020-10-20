module Accounts
  class Withdraw
    def self.call(account, value)
      account.withdraw_balance(value)

      Transaction.new(
        sender_id: account.id,
        receiver_id: account.id,
        t_type: 'Withdrawal',
        value: value
      )
    end
  end
end
