class AddSubIdToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :sub_id, :string
  end
end
