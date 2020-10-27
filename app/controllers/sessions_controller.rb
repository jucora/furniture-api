class SessionsController < ApplicationController
    def create 
        user = User
                .find_by(email: session_params[:email])
                .try(:authenticate, session_params[:password])
    
        if user
            payload = {user_id: user.id, email: user.email}
            token = encode_token(payload)  
            render json: {
                status: :created,
                logged_in: true,
                user: user,
                jwt: token,
            }
        else
          render json: { status: 401, error: 'Invalid user or password' }
        end
    end

    def logged_in
        if request.headers['Authorization'] != 'null'
            user = User.find(decode_token(request.headers['Authorization']))
        end
        
        if user
            render json: {
                logged_in: true,
                current_user: user
            }
        else
            render json: {
                logged_in: false
            }
        end
    end
    private
    def session_params
        params.require(:user).permit(:email, :password)
    end
end