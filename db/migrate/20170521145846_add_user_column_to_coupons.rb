class AddUserColumnToCoupons < ActiveRecord::Migration[5.0]
  def change
    add_reference :coupons, :user, foreign_key: true
  end
end
