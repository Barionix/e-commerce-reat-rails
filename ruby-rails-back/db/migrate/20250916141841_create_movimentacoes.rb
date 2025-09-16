class CreateMovimentacoes < ActiveRecord::Migration[7.0]
  def change
    create_table :movimentacoes do |t|
      t.string :tipo, null: false               # enum: entrada (0), saída (1)
      t.string :nome, null: false
      t.string :descricao
      t.decimal :valor, precision: 15, scale: 2, null: false
      t.datetime :data, null: false

      t.timestamps
    end
  end
end
