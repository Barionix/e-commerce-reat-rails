class Api::V1::ShartsController < ApplicationController  
    def publishChart
        code = Chart.generate_unique_code

        chart = Chart.new(
        code: code,
        chart_json: params[:chart],
        preco: params[:preco],
        nome: params[:nome]
        )

        if chart.save
        render json: chart.code, status: 201
        else
        render json: { message: "Erro ao publicar carrinho", errors: chart.errors.full_messages }, status: 403
        end
    rescue => e
        Rails.logger.error("Erro ao publicar carrinho: #{e.message}")
        render json: { message: "Erro ao publicar carrinho" }, status: 403
    end

  def getChartByID
    chart = Chart.find_by(code: params[:id])

    if chart
      render json: chart, status: 200
    else
      render json: { message: "chart não encontrado." }, status: 404
    end
  rescue => e
    Rails.logger.error("Erro ao buscar chart por ID: #{e.message}")
    render json: { message: "Erro ao buscar chart." }, status: 500
  end
end
