class Api::V1::AuthController < ApplicationController
  require "jwt"

  def login
    usuario = User.find_by(email: params[:email])
    if usuario&.authenticate(params[:password])
      payload = { user_id: usuario.id, exp: 1.hour.from_now.to_i }
      token = JWT.encode(payload, "aaaa", "HS256")

      render json: {
        auth: true,
        token: token,
        user: usuario.as_json(except: [:password_digest]) 
      }, status: :ok
    else
      render json: { error: "Login recusado!" }, status: :unauthorized
    end
  rescue => e
    Rails.logger.error e.message
    render json: { error: "Erro no login" }, status: :internal_server_error
  end
end
