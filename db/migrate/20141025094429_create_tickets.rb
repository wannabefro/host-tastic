class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :subject
      t.integer :department_id, null: false
      t.text :body, null: false
      t.string :reference, null: false
      t.integer :assigned_staff_id
      t.integer :status, null: false, default: 0
      t.timestamps
    end
    add_index :tickets, :reference, unique: true
    add_index :tickets, :department_id
    add_index :tickets, :assigned_staff_id
  end
end
