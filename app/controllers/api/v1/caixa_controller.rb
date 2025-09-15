class Api::V1::CaixaController < ApplicationController
    def cadastrarMovimentacao
        ActiveRecord::Base.transaction do
        # Cria movimentação
        movimentacao = Movimentacao.create!(
            tipo: params[:tipo],
            nome: params[:nome],
            descricao: params[:descricao],
            valor: params[:valor],
            data: Time.current
        )

        # Busca ou cria caixa
        caixa = Caixa.first_or_create!(saldo_total: 0, saldo_estimado: 0)

        # Atualiza valores do caixa
        if movimentacao.tipo == "entrada"
            caixa.saldo_total += movimentacao.valor
            caixa.saldo_estimado += movimentacao.valor
        else
            caixa.saldo_total -= movimentacao.valor
            caixa.saldo_estimado -= movimentacao.valor
        end

        caixa.save!

        render json: {
            message: "Movimentação cadastrada e caixa atualizado com sucesso",
            movimentacao: movimentacao,
            caixa: caixa
        }, status: :created
        end
    rescue => e
        Rails.logger.error("Erro ao cadastrar movimentação: #{e.message}")
        render json: { message: "Erro ao cadastrar movimentação", error: e.message }, status: :internal_server_error
    end
end
