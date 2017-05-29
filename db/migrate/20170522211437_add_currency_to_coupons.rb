class AddCurrencyToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_column :coupons, :currency, :string
  end
end
