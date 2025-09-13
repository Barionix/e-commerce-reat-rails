class Api::V1::UsersController < ApplicationController
    def createAdmin
        @user = User.new(user_params)
        if @user.save 
            render json: @user 
        else 
            render error: { error: 'Não foi possivel criar o usuário'}, status: 400
        end
    end 

    def user_params
        params.require(:user).permit(:email, :password)
    end 
end
