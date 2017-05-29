class CreateSplans < ActiveRecord::Migration[5.0]
  def change
    create_table :splans do |t|
      t.string :name
      t.string :stripe_id
      t.string :interval
      t.integer :amount

      t.timestamps
    end
  end
end
