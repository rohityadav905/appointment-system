class Api::V1::AppointmentsController <  Api::V1::ApiController
   def index
   	 render json: {appointments: current_user.appointments}, status: 200
   end

   def create
   	 if current_user.is_doctor?
   	 	appointment = Appointment.new(doctor_id: current_user.id, patient_id: params[:user_id],
   	 		start_date_time: params[:start_date_time], end_date_time: params[:end_date_time])
   	 else
   	 	appointment = Appointment.new(doctor_id: params[:user_id], patient_id: current_user.id,
   	 		start_date_time: params[:start_date_time], end_date_time: params[:end_date_time])
   	 end
   	 if appointment.save
   	 	render json: {appointments: current_user.appointments}, status: 200
   	 else
	    render json: {error: appointment.errors.full_messages[0] },status: 400
   	 end
   end

   def edit
   	 appointment = Appointment.find(params[:appointment_id])
   	 render json: {appointment: appointment},status: 200
   end

   def update
   	appointment = Appointment.find(params[:appointment_id])
   	if appointment.update(start_date_time: params[:start_date_time], end_date_time: params[:end_date_time])
   		 render json: {appointment: appointment},status: 200
	else
		render json: {error: appointment.errors.full_messages[0] },status: 400
	end   	
   end

    def destroy
   	appointment = Appointment.find(params[:appointment_id])
   	if appointment.destroy
   		 render json: {success: "successfully deleted"},status: 200
	else
		render json: {error: appointment.errors.full_messages[0] },status: 400
	end   	
   end
end
