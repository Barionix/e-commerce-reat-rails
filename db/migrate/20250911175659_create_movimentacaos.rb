class CreateMovimentacaos < ActiveRecord::Migration[7.0]
  def change
    create_table :movimentacaos do |t|
      t.string :tipo, null: false
      t.string :nome, null: false
      t.string :descricao
      t.decimal :valor, null: false
      t.datetime :data, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
