class Cupom < ApplicationRecord
  validates :code, presence: true
  validates :desconto, presence: true
end
