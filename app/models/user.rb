class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email, :password, :password_confirmation
    validates_uniqueness_of :email

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

    has_many :skills, class_name: 'Skill', dependent: :destroy

    def self.getScores userId
        Skill.joins(:measures).select('SUM(score) as total').where('user_id =?', userId)
    end

    def self.currentSkills userId
        Skill.joins(:measures).select('skill_id, name, SUM(score)').group("name, skill_id").where(user_id: userId )
    end
end