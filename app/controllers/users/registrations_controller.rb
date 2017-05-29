class Users::RegistrationsController < Devise::RegistrationsController
	layout 'signup', only: [:new]

	def after_sign_up_path_for(resource)
		'/charges/new'
	end

	def new
		build_resource({})
		unless params[:plan].nil?
      		@plan = Plan.find_by!(stripe_id: params[:plan])
      		resource.plan = @plan
    	end
    	yield resource if block_given?
    	respond_with self.resource
	end

	def create
		build_resource(sign_up_params)
		plan = Plan.find_by!(id: (params[:user][:plan_id]).to_i)
    	resource.role = User.roles[plan.stripe_id]
		resource.save
		yield resource if block_given?
		if resource.persisted?
			if resource.active_for_authentication?
				set_flash_message! :notice, :signed_up
				sign_up(resource_name, resource)
				respond_with resource, location: after_sign_up_path_for(resource)
			else
				set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
				expire_data_after_sign_in!
				respond_with resource, location: after_inactive_sign_up_path_for(resource)
			end
		else
			clean_up_passwords resource
			set_minimum_password_length
			response_to_sign_up_failure resource    
		end
	end


	

	private

	def response_to_sign_up_failure(resource)
		if resource.email == "" && resource.password == nil
			redirect_to new_user_registration_path, alert: "Please fill in the form to proceed."
		elsif User.pluck(:email).include? resource.email
			redirect_to new_user_registration_path, alert: "Email already exists."
		end
	end

	 def sign_up_params
	    params.require(:user).permit(:email,
	    :password, :password_confirmation, :plan_id)
	  end
end