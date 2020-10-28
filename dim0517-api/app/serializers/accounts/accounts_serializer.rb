module Accounts
  class AccountsSerializer
    def self.serialize!(accounts)
      {
        users: Array.new.tap do |array|
          accounts.each do |account|
            user_id = account.user.id

            array.push(
              {
                id: user_id,
                first_name: account.user.first_name,
                last_name: account.user.last_name,
                email: account.user.email,
                account: {
                  id: account.id,
                  account_number: account.account_number,
                  bank_number: account.bank_number,
                  balance: account.balance,
                  bonus_balance: account.bonus_balance,
                  user_id: user_id
                }
              }
            )
          end
        end,
        total_users: accounts.size
      }
    end
  end
end
