class AddCodeToCargo < ActiveRecord::Migration[5.2]
  def change
    add_column :cargos, :code, :string, unique: true
    add_column :io_logs, :code, :string
    add_index :cargos, :code
  end
end
