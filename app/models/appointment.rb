class Appointment < ApplicationRecord
   belongs_to :doctor, :class_name => 'User',foreign_key: :doctor_id 
   belongs_to :patient, :class_name => 'User',foreign_key: :patient_id 
   validate :datetime_is_valid



   def datetime_is_valid
   	self.doctor.appointments.each do |appointment|
   		
   		if((appointment.start_date_time...appointment.end_date_time).include?(self.start_date_time) || (appointment.start_date_time...appointment.end_date_time).include?(self.end_date_time))
   			 errors.add(:error, "date and time is not valid ") 
   		end	
   	end
	 #  return if slot.blank?

	 #  if slot.to_time < Time.zone.now.to_time
	 #    errors.add(:slot, "date and time is not valid ") 
	 #  else
		#   blackouts = BlackoutDate.where(['blackout_end_date >= ? AND blackout_start_date <= ?', slot, slot]) 
		#   unless blackouts.empty? 
		#   	errors.add(:slot, "should not between block dates") 
		#   end
		# end
	end
end
