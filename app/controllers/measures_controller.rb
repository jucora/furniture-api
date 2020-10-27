class MeasuresController < ApplicationController
    def index
        user = User.find(decode_token(request.headers['Authorization']))
        totalScore = User.getScores(user.id)
        
        if totalScore
            render json: {
                status: :founded,
                totalScore: totalScore,
            }
        else
            render json:{
                status: 500
            }
        end
    end


    def create
        newScore = Measure.new(skill_id: measure_params[:id], score: measure_params[:newScore])
        if newScore.save
            render json: {
                status: :updated,
                newScore: newScore
            }
        else
            render json:{
                status: 500,
                errors: newScore.errors.full_messages
            }
        end
    end

    private
    def measure_params
        params.require(:measure).permit(:id, :newScore)
    end
end