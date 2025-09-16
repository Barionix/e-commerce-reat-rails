class Api::V1::CaixaController < ActionController::API

  # POST /api/v1/caixa/cadastrarMovimentacao
  def cadastrarMovimentacao
    puts ("heheheh")
    puts (mov_params)
    movimentacao = Movimentacao.new(mov_params)
    puts ("after")
    if movimentacao.save
      render json: { message: "Movimentação cadastrada com sucesso", movimentacao: movimentacao }, status: :created
    else
      render json: { message: "Erro ao cadastrar movimentação", errors: movimentacao.errors.full_messages }, status: :unprocessable_entity
    end
 
 #   Rails.logger.error("Erro ao cadastrar movimentaçãooooo: #{e.message}")
  #  render json: { message: "Erro ao cadastrar movimentação", error: e.message }, status: :internal_server_error
  end

  # GET /api/v1/caixa/movimentacoes
  def listarMovimentacoes
    movimentacoes = Movimentacao.order(data: :desc)
    render json: movimentacoes, status: :ok
  rescue => e
    Rails.logger.error("Erro ao listar movimentações: #{e.message}")
    render json: { message: "Erro ao listar movimentações", error: e.message }, status: :internal_server_error
  end

  def deletarMovimentacao
    movimentacao = Movimentacao.find_by(id: params[:id])
    return render json: { message: "Movimentação não encontrada" }, status: :not_found unless movimentacao

    movimentacao.destroy!
    render json: { message: "Movimentação deletada com sucesso" }, status: :ok
  rescue => e
    Rails.logger.error("Erro ao deletar movimentação: #{e.message}")
    render json: { message: "Erro ao deletar movimentação", error: e.message }, status: :internal_server_error
  end

  def editarMovimentacao
    movimentacao = Movimentacao.find_by(id: params[:id])
    return render json: { message: "Movimentação não encontrada" }, status: :not_found unless movimentacao

    mov_params = params.permit(:tipo, :nome, :descricao, :valor)
    tipo_param = mov_params[:tipo].to_s
    unless Movimentacao.tipos.keys.include?(tipo_param)
      return render json: { message: "Tipo inválido" }, status: :unprocessable_entity
    end

    movimentacao.assign_attributes(mov_params.to_h)
    movimentacao.save!

    render json: { message: "Movimentação atualizada com sucesso", movimentacao: movimentacao }, status: :ok
  rescue => e
    Rails.logger.error("Erro ao atualizar movimentação: #{e.message}")
    render json: { message: "Erro ao atualizar movimentação", error: e.message }, status: :internal_server_error
  end

  def obterCaixa
    caixa = Caixa.first
    unless caixa
      caixa = Caixa.create!(saldo_total: 0, saldo_estimado: 0)
    end

    render json: caixa, status: :ok
  rescue => e
    Rails.logger.error("Erro ao obter caixa: #{e.message}")
    render json: { message: "Erro ao obter caixa", error: e.message }, status: :internal_server_error
  end

  private
  def mov_params
    params.require(:movimentacao).permit(:nome, :descricao, :valor, :tipo, :caixa_id)
  end
  def ensure_json_request
    render json: { message: "Formato JSON obrigatório" }, status: 406 unless request.format.json?
  end
end
