class Sale < ApplicationRecord
  validates :code, presence: true
  validates :preco, presence: true
end
