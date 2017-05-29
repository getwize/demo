class CreateCoupons < ActiveRecord::Migration[5.0]
  def change
    create_table :coupons do |t|
      t.string :coup_id
      t.string :duration
      t.integer :duration_in_months
      t.integer :amount_off

      t.timestamps
    end
  end
end
