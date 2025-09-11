class Movimentacao < ApplicationRecord
  enum tipo: { entrada: "entrada", saida: "saida" }

  validates :tipo, presence: true, inclusion: { in: tipos.keys }
  validates :nome, presence: true
  validates :valor, presence: true

  before_save :strip_strings

  private

  # trim equivalent: remove espaços antes/depois dos campos string
  def strip_strings
    self.nome = nome.strip if nome.present?
    self.descricao = descricao.strip if descricao.present?
  end
end
