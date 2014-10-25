class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :ticket_id, null: false
      t.string :notes, null: false

      t.timestamps
    end
    add_index :histories, :ticket_id
  end
end
