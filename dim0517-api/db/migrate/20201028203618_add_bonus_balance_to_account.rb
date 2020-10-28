class AddBonusBalanceToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :bonus_balance, :decimal, precision: 9, scale: 3, default: 0.00
  end
end
