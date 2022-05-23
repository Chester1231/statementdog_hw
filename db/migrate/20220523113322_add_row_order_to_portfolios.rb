class AddRowOrderToPortfolios < ActiveRecord::Migration[6.1]
  def change
    add_column :portfolios, :row_order, :integer
    add_index :portfolios, :row_order
  end
end
