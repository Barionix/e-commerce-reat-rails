class Caixa < ApplicationRecord
  # validações (equivalente ao "required" do mongoose)
  validates :saldo_total, presence: true
  validates :saldo_estimado, presence: true

  # atualiza data_atualizacao automaticamente antes de salvar
  before_save :update_data_atualizacao

  private

  def update_data_atualizacao
    self.data_atualizacao = Time.current
  end
end
