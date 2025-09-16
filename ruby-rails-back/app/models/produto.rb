class Produto < ApplicationRecord
  validates :nome, presence: true
  validates :preco, presence: true
  validates :categoria, presence: true
  validates :estoque, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :img, presence: true

  # Se quiser garantir que o array não esteja vazio
  validate :img_nao_vazio

  private

  def img_nao_vazio
    errors.add(:img, "não pode ser vazio") if img.blank? || img.empty?
  end
end
