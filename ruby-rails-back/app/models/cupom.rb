class Cupom < ApplicationRecord
  self.table_name = "cupons"
  validates :code, presence: true
  validates :desconto, presence: true
end
