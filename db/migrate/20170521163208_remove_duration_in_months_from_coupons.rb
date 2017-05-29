class RemoveDurationInMonthsFromCoupons < ActiveRecord::Migration[5.0]
  def change
    remove_column :coupons, :duration_in_months, :integer
  end
end
