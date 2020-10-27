require 'jwt'
class ApplicationController < ActionController::Base
    
    skip_before_action :verify_authenticity_token
    include Knock::Authenticable

    def encode_token payload
        JWT.encode(payload, 'secret')
    end
    
    def decode_token payload
        JWT.decode(payload, 'secret')[0]['user_id']
    end
end