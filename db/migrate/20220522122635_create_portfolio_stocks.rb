class CreatePortfolioStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :portfolio_stocks do |t|
      t.integer :portfolio_id
      t.string :ticker

      t.timestamps
    end

    add_index :portfolio_stocks, [:portfolio_id, :ticker], unique: true
  end
end
