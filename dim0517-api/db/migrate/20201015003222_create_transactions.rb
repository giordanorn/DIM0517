class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :value
      t.references :sender
      t.references :receiver

      t.timestamps
    end
  end
end
