class CreateCaixas < ActiveRecord::Migration[7.0]
  def change
    create_table :caixas do |t|
      t.decimal :saldo_total, null: false, default: 0
      t.decimal :saldo_estimado, null: false, default: 0
      t.datetime :data_atualizacao, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
