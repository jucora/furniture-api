class User < ApplicationRecord
    has_secure_password
    validates_presence_of :email, :password, :password_confirmation
    validates_uniqueness_of :email

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

    has_many :customers, class_name: 'Customer', dependent: :destroy

    def self.currentEmployees userId
        select('employee_id, name, rol').group("name, employee_id").where(user_id: userId )
    end

    def self.currentCustomers userId
        # select('customer_id, name').group("name, employee_id").where(user_id: userId )
        Customer.where(user_id: userId)
    end
end