require 'rails_helper'

describe Accounts::AccountsSerializer do
  describe '.serialize!' do
    let!(:first_account) { FactoryBot.create(:account) }
    let!(:second_account) { FactoryBot.create(:account) }

    subject { described_class.serialize!(Account.all) }

    it 'returns an array with serialized infos of all accounts' do
      expect(subject).to eq(
        {
          users: [
            {
              id: first_account.user.id,
              first_name: first_account.user.first_name,
              last_name: first_account.user.last_name,
              email: first_account.user.email,
              account: {
                id: first_account.id,
                account_number: first_account.account_number,
                bank_number: first_account.bank_number,
                balance: first_account.balance,
                user_id: first_account.user.id
              }
            },
            {
              id: second_account.user.id,
              first_name: second_account.user.first_name,
              last_name: second_account.user.last_name,
              email: second_account.user.email,
              account: {
                id: second_account.id,
                account_number: second_account.account_number,
                bank_number: second_account.bank_number,
                balance: second_account.balance,
                user_id: second_account.user.id
              }
            }
          ],
          total_users: 2
        }
      )
    end
  end
end
