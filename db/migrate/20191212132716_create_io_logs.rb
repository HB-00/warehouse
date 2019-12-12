class CreateIoLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :io_logs do |t|
      t.integer :user_id
      t.integer :cargo_id
      t.integer :kind
      t.integer :quantity

      t.timestamps
    end
    add_index :io_logs, :user_id
    add_index :io_logs, :cargo_id
  end
end
