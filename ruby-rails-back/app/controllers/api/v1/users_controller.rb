class Api::V1::UsersController < ApplicationController
  def createAdmin
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(except: [:password_digest]), status: :created
    else
      render json: { error: 'Não foi possível criar o usuário', details: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
