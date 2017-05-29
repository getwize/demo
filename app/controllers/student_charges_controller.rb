class StudentChargesController < ApplicationController
before_action :authenticate_user!

#updates student card
	def update
  		@student = Student.find_by(id: params[:id])
  		@user = current_user
	  	@plan = Plan.find_by!(id: @user.plan_id)
		if Rails.env.production?
     		 Stripe.api_key = @user.access_code #@user.access_code
    	else
     		 Stripe.api_key = @user.access_code
     	end

		  token = params[:stripeToken]
		  customer = Stripe::Customer.retrieve(@student.stripe_id)
		  customer.source = token 
		  customer.save
		  redirect_to root_path
 	 end
end
