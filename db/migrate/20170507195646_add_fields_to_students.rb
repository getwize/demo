class AddFieldsToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :street_address, :string
    add_column :students, :city, :string
    add_column :students, :state, :string
    add_column :students, :zip, :string
    add_column :students, :emergency_contact_name, :string
    add_column :students, :emergency_contact_relationship, :string
    add_column :students, :emergency_contact_phone, :string
    add_column :students, :emergency_medical_info, :string
    add_column :students, :uniform_size, :string
    add_column :students, :belt_size, :string
    add_column :students, :birthday, :date
  end
end
