class CustomersController < ApplicationController
    def index
        user = User.find(decode_token(request.headers['Authorization']))
        currentCustomers = User.currentCustomers(user.id)
        if currentCustomers
            render json: {
            status: :founded,
            currentCustomers: currentCustomers
        }
        else
            render json:{
            status: 500
            }
        end
    end
    
    def create 
        user = User.find(decode_token(customer_params[:token]))
        newCustomer = Customer.new(name: customer_params[:name], email: customer_params[:email], user_id: user.id)
        if newCustomer.save
                render json: {
                status: :created,
                newCustomer: newCustomer,
            }
        else
            render json:{
                status: false,
                errors: newCustomer.errors.full_messages
            }
        end
    end

    def destroy
        Customer.find(params[:customer_id]).destroy
        render json: {status: 'SUCCESS', message: 'Customer removed'}, status: :ok
    end

    private

    def customer_params
        params.require(:newCustomer).permit(:name, :email, :token)
    end  


end
