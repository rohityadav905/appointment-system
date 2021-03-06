class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tokens, dependent: :destroy
  has_many :doctor_appointments, :class_name => 'Appointment',foreign_key: :doctor_id 
  has_many :patient_appointments, :class_name => 'Appointment',foreign_key: :patient_id 
  # has_many :patients, through: :appointments, :class_name => 'Appointment',foreign_key: :patient_id 
  # has_many :doctors, through: :appointments, :class_name => 'Appointment',foreign_key: :doctor_id 
 
  def appointments
  	role == 1 ? doctor_appointments : patient_appointments
  end

  def generate_auth_token!
    loop do
      @token = Devise.friendly_token
      break unless Token.find_by(token: @token)
    end
    self.tokens.create token: @token
    return @token
  end

  def is_doctor?
  	return role === 1 
  end

end
