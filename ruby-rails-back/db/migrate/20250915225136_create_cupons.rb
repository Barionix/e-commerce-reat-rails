class CreateCupons < ActiveRecord::Migration[8.0]
  def change
    create_table :cupons do |t|
      t.string :code
      t.string :autor
      t.decimal :desconto

      t.timestamps
    end
  end
end
