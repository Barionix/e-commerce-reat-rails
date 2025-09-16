# app/controllers/api/v1/produtos_controller.rb
class Api::V1::ProdutosController < ActionController::API
  def createProduct
    if !params[:img] 
      return render json: { message: 'Pelo menos uma imagem é obrigatória.' }, status: 400
    end

    # Salva as imagens localmente (ou via Active Storage se preferir)
    imagens_paths = Array.wrap(params[:img]).map do |imagem|
      path = Rails.root.join('public', 'uploads', imagem.original_filename)
      File.open(path, 'wb') { |f| f.write(imagem.read) }
      "/uploads/#{imagem.original_filename}"
    end


    produto = Produto.new(
      nome: params[:nome],
      descricao: params[:descricao],
      preco: params[:preco],
      preco_com_desconto: params[:precoComDesconto],
      categoria: params[:categoria],
      estoque: params[:estoque],
      img: imagens_paths,
      reserva: ActiveModel::Type::Boolean.new.cast(params[:reserva]),
      visivel: ActiveModel::Type::Boolean.new.cast(params[:visivel])
    )

    if produto.save
      render json: produto, status: 201
    else
      render json: { message: 'Erro ao cadastrar produto.', errors: produto.errors.full_messages }, status: 500
    end
  end

  def listProducts 
    produtos = Produto.all
    render json: produtos, status: 200
  rescue => e
    render json: { message: "Erro ao listar produtos.", error: e.message }, status: 500
  end


  def productUpdate
    produto = Produto.find_by(id: params[:id])

    if produto.nil?
      return render json: { message: "Produto não encontrado." }, status: 404
    end

    imagens_paths = if params[:imagens].present?
      Array.wrap(params[:imagens]).map do |imagem|
        path = upload_dir.join(imagem.original_filename)
        File.open(path, 'wb') { |f| f.write(imagem.read) }
        "/uploads/#{imagem.original_filename}"
      end
    else
      produto.img 
    end

    preco_com_desconto = begin
      Float(params[:precoComDesconto])
    rescue
      nil
    end

    produto.nome               = params[:nome] if params[:nome].present?
    produto.descricao          = params[:descricao] if params[:descricao].present?
    produto.preco              = params[:preco] if params[:preco].present?
    produto.preco_com_desconto = preco_com_desconto if preco_com_desconto
    produto.categoria          = params[:categoria] if params[:categoria].present?
    produto.estoque            = params[:estoque] if params[:estoque].present?
    produto.reserva            = ActiveModel::Type::Boolean.new.cast(params[:reserva]) unless params[:reserva].nil?
    produto.visivel            = ActiveModel::Type::Boolean.new.cast(params[:visivel]) unless params[:visivel].nil?
    produto.img                = imagens_paths

    if produto.save
      render json: produto, status: 200
    else
      render json: { message: "Erro ao editar produto.", errors: produto.errors.full_messages }, status: 500
    end
  end

  def getProductByID
    produto = Produto.find_by(id: params[:id])

    if produto
      render json: produto, status: 200
    else
      render json: { message: "Produto não encontrado." }, status: 404
    end
  rescue => e
    Rails.logger.error("Erro ao buscar produto por ID: #{e.message}")
    render json: { message: "Erro ao buscar produto." }, status: 500
  end

end
