class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.string :nome, null: false
      t.string :descricao
      t.decimal :preco, null: false
      t.decimal :preco_com_desconto, default: 0
      t.string :categoria, null: false
      t.integer :estoque, null: false, default: 0
      t.text :img, array: true, default: [], null: false  # <== aqui
      t.boolean :reserva, default: false
      t.boolean :visivel, default: false

      t.timestamps
    end
  end
end
