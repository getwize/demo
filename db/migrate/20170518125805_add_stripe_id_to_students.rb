class AddStripeIdToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :stripe_id, :string
  end
end
