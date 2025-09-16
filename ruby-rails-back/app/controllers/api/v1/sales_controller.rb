class SalesController < ApplicationController
  def confirmSale
    begin

      sale = Sale.new(
        code: params[:code],
        chart: params[:chart],
        preco: params[:preco],
        nome: params[:nome],
        status: params[:status],
        valor_final: params[:valorFinal]
      )

      chart = JSON.parse(params[:chart])

      chart.each do |product|
        produto = Produto.find(product["id"])
        produto.update!(estoque: produto.estoque - 1)
      end

      sale.save!

      render json: { message: "Compra confirmada com sucesso!" }, status: :ok
    rescue => e
      Rails.logger.error e.message
      render json: { error: "Erro ao confirmar compra" }, status: :forbidden
    end
  end
end
