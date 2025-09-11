class CreateCupons < ActiveRecord::Migration[7.0]
  def change
    create_table :cupons do |t|
      t.string :code, null: false
      t.string :autor
      t.decimal :desconto, null: false

      t.timestamps
    end
  end
end
