class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :body, null: false
      t.integer :staff_id
      t.integer :ticket_id, null: false

      t.timestamps
    end
    add_index :responses, :ticket_id
    add_index :responses, :staff_id
  end
end
