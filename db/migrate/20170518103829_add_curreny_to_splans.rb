class AddCurrenyToSplans < ActiveRecord::Migration[5.0]
  def change
    add_column :splans, :currency, :string
  end
end
