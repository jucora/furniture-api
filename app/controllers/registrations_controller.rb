class RegistrationsController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            payload = {user_id: user.id, email: user.email}
            token = encode_token(payload)  
            render json: {
                status: :created,
                user: user,
                jwt: token
            }

        else
            render json:{
                status: 500,
                errors: user.errors.full_messages
            }
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end