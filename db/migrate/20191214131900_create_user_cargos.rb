class CreateUserCargos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_cargos do |t|
      t.integer :user_id
      t.integer :cargo_id
      t.integer :quantity, default: 0

      t.timestamps
    end
    add_index :user_cargos, :user_id
    add_index :user_cargos, :cargo_id
  end
end
