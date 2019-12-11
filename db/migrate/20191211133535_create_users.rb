class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, unique: true
      t.string :name
      t.string :password_digest
      t.integer :role

      t.timestamps
    end
    add_index :users, :email
  end
end
