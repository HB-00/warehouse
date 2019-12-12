class CreateCargos < ActiveRecord::Migration[5.2]
  def change
    create_table :cargos do |t|
      t.string :name
      t.string :no, unqiue: true
      t.string :category
      t.integer :total_quantity
      t.integer :in_stock_quantity
      t.text :description

      t.timestamps
    end
    add_index :cargos, :no
  end
end
