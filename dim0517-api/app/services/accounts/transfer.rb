module Accounts
  class Transfer
    def self.call(sender, receiver, value)
      receiver.add_balance(value)
      sender.withdraw_balance(value)

      Transaction.new(
        sender_id: sender.id,
        receiver_id: receiver.id,
        t_type: 'Transfer',
        value: value
      )
    end
  end
end
