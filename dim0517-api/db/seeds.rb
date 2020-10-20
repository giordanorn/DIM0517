User.create(first_name: 'John', last_name: 'Johnson', email: 'john@johnson')
User.create(first_name: 'Mary', last_name: 'Adams', email: 'mary@adams')
User.create(first_name: 'Billy', last_name: 'Smith', email: 'billy@smith')

Account.create(
  account_number: '00001',
  bank_number: '00000001',
  user_id: 1,
  balance: 100.00
)

Account.create(
  account_number: '00002',
  bank_number: '00000001',
  user_id: 2,
  balance: 200.00
)

Account.create(
  account_number: '00001',
  bank_number: '00000002',
  user_id: 3,
  balance: 300.00
)
