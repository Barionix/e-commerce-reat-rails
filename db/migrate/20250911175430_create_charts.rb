class CreateCharts < ActiveRecord::Migration[7.0]
  def change
    create_table :charts do |t|
      t.string :code, null: false
      t.string :nome
      t.string :chart_json
      t.decimal :preco, null: false

      t.timestamps
    end
  end
end
