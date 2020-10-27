class SkillsController < ApplicationController
    def index
        user = User.find(decode_token(request.headers['Authorization']))
        currentSkills = User.currentSkills(user.id)
        if currentSkills
            render json: {
                status: :founded,
                currentSkills: currentSkills
            }
        else
            render json:{
                status: 500
            }
        end
    end

    def create 
        user = User.find(decode_token(skill_params[:token]))
        newSkill = Skill.new(name: skill_params[:name], user_id: user.id)
        if newSkill.save
            newMeasure = Measure.create!(skill_id: newSkill.id)
            if newMeasure
                render json: {
                status: :created,
                newSkill: newSkill,
                newMeasure: newMeasure
            }
            end
        else
            render json:{
                status: false,
                errors: newSkill.errors.full_messages
            }
        end
    end

    def destroy
        Skill.find(params[:skill_id]).destroy
        render json: {status: 'SUCCESS', message: 'Skill removed'}, status: :ok
    end

    private

    def skill_params
        params.require(:newSkill).permit(:name, :token)
    end  
end