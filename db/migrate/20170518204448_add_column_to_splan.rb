class AddColumnToSplan < ActiveRecord::Migration[5.0]
  def change
    add_reference :splans, :user, foreign_key: true
  end
end
