class CreateApiv1Employees < ActiveRecord::Migration
  def change
    create_table :apiv1_employees do |t|
      t.string :person_name
      t.string :employee_title
      t.string :email
      t.string :phone_number
      t.timestamps
    end
  end
end
