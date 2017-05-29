class AddSplanIdToStudents < ActiveRecord::Migration[5.0]
  def change
    add_reference :students, :splan, foreign_key: true
  end
end
