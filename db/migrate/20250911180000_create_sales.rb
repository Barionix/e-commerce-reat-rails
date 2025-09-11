class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.string :code, null: false
      t.string :nome
      t.string :chart
      t.decimal :preco, null: false
      t.decimal :valor_final
      t.string :status, default: 'Pending'

      t.timestamps
    end
  end
end
