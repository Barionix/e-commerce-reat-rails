# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_16_141841) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "caixas", force: :cascade do |t|
    t.decimal "saldo_total", default: "0.0", null: false
    t.decimal "saldo_estimado", default: "0.0", null: false
    t.datetime "data_atualizacao", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charts", force: :cascade do |t|
    t.string "code", null: false
    t.string "nome"
    t.string "chart_json"
    t.decimal "preco", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cupons", force: :cascade do |t|
    t.string "code"
    t.string "autor"
    t.decimal "desconto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movimentacaos", force: :cascade do |t|
    t.string "tipo", null: false
    t.string "nome", null: false
    t.string "descricao"
    t.decimal "valor", null: false
    t.datetime "data", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "caixa_id", null: false
    t.index ["caixa_id"], name: "index_movimentacaos_on_caixa_id"
  end

  create_table "movimentacoes", force: :cascade do |t|
    t.integer "tipo", null: false
    t.string "nome", null: false
    t.string "descricao"
    t.decimal "valor", precision: 15, scale: 2, null: false
    t.datetime "data", null: false
    t.bigint "caixa_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["caixa_id"], name: "index_movimentacoes_on_caixa_id"
  end

  create_table "produtos", force: :cascade do |t|
    t.string "nome", null: false
    t.string "descricao"
    t.decimal "preco", null: false
    t.decimal "preco_com_desconto", default: "0.0"
    t.string "categoria", null: false
    t.integer "estoque", default: 0, null: false
    t.text "img", default: [], null: false, array: true
    t.boolean "reserva", default: false
    t.boolean "visivel", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.string "code", null: false
    t.string "nome"
    t.string "chart"
    t.decimal "preco", null: false
    t.decimal "valor_final"
    t.string "status", default: "Pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  add_foreign_key "movimentacaos", "caixas"
  add_foreign_key "movimentacoes", "caixas"
end
