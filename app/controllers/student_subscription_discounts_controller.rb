class StudentSubscriptionDiscountsController < ApplicationController
	before_action :authenticate_user!
	def new
		@coupon = Coupon.new
	end

#creates a coupon on stripe
	def create
		@user = current_user
		@coupon = @user.coupons.new(coupon_params)
		Stripe.api_key = @user.access_code

		if @coupon.duration == "once"
		
		Stripe::Coupon.create(
		  :amount_off => @coupon.amount_off,
		  :duration => @coupon.duration,
		  :id => @coupon.coup_id,
		  :currency => @coupon.currency
		)
			@coupon.save

		elsif @coupon.duration == 'forever'
		
		Stripe::Coupon.create(
		  :amount_off => @coupon.amount_off,
		  :duration => @coupon.duration,
		  :id => @coupon.coup_id,
		  :currency => @coupon.currency
		)
			@coupon.save

		else
		Stripe::Coupon.create(
		  :amount_off => @coupon.amount_off,
		  :duration => @coupon.duration,
		  :id => @coupon.coup_id,
		  :duration_in_months => @coupon.duration_in_months,
		  :currency => @coupon.currency
		)
			@coupon.save
		end
			redirect_to root_path
		
	end
# Creates a Coupon then Discounts a Subscription
	def update
		@user = current_user
		@student = Student.find_by(id: params[:id])
		@plan = Splan.find_by!(id: @student.splan_id)
		@param = Coupon.new(claim_params)
		@coupon = Coupon.find_by(id: @param.coup_id)
		Stripe.api_key = @user.access_code

		Stripe::Subscription.create(
			  :customer => @student.stripe_id,
			  :plan => @plan.stripe_id,
			  :coupon => @coupon.coup_id,
			)
		redirect_to root_url
	end

	private

	def coupon_params
	    params.require(:coupon).permit(:coup_id,:duration,:duration_in_months,:amount_off,:currency)
	end

	def claim_params
		params.require(:discount).permit(:coup_id,:id)
	end

end
