class Api::V1::CuponsController < ApplicationController
    def cadastrarCupom
        cupom = Cupom.new(cupom_params)

        if cupom.save
            render json: cupom, status: :created
        else
            render json: { message: "Erro ao cadastrar cupom", errors: cupom.errors.full_messages }, status: :internal_server_error
        end
    rescue => e
        Rails.logger.error("Erro ao cadastrar cupom: #{e.message}")
        render json: { message: "Erro ao cadastrar cupom", error: e.message }, status: :internal_server_error
    end


    def validarCupom
        cupom = Cupom.find_by(code: params[:codigo])
        if cupom
            render json: cupom, status: :ok
        else
            render json: { message: "Cupom não encontrado" }, status: :not_found
        end
    rescue => e
        Rails.logger.error("Erro ao validar cupom: #{e.message}")
        render json: { message: "Erro ao validar cupom", error: e.message }, status: :internal_server_error
    end 

    def listarCupons
        cupons = Cupom.order(created_at: :desc)
        render json: cupons, status: :ok
        rescue => e
            Rails.logger.error("Erro ao listar cupons: #{e.message}")
            render json: { message: "Erro ao listar cupons", error: e.message }, status: :internal_server_error
    end

    private

    def cupom_params
        params.require(:cupom).permit(:code, :autor, :desconto)
    end
end
