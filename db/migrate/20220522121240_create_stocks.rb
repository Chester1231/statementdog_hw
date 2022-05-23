class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks do |t|
      t.string :ticker, limit: 20
      t.string :market_type
      t.string :exchange_market
      t.string :company_name
      t.string :company_description
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :stocks, :ticker, unique: true
    add_index :stocks, :market_type
    add_index :stocks, :deleted_at
  end
end
