class ChargesController < ApplicationController
	
	before_action :authenticate_user!
	def new
		@user = current_user
		@plan = Plan.find_by!(id: @user.plan_id)
	end
	
	# Creates a Stripe Subscription Upon Payment of Plan
	def create
		
		@user = current_user
		@plan = Plan.find_by!(id: @user.plan_id)
		token = params[:stripeToken]

		if Rails.env.production?
			Stripe.api_key = ENV['STRIPE_SECRET_KEY']
		else
			Stripe.api_key = ENV['STRIPE_SECRET_KEY'] 
		end

		customer = Stripe::Customer.create(
			email: current_user.email,
			source: token
			)

		subscription = Stripe::Subscription.create(
			:customer    => customer.id,
			:plan 		 => @plan.stripe_id
			
			)
		@user.stripe_id  = customer.id
		@user.sub_id = subscription.id
		@user.save

	rescue Stripe::CardError => e
		flash[:error] = e.message

		redirect_to new_charge_path
	end

	def edit
		@user = current_user
	end
# Updates User Card Details in Stripe
def update
	
	@user = current_user
	@plan = Plan.find_by!(id: @user.plan_id)
	if Rails.env.production?
		Stripe.api_key = ENV['STRIPE_SECRET_KEY']
	else
		Stripe.api_key = ENV['STRIPE_SECRET_KEY']
	end

	token = params[:stripeToken]
	customer = Stripe::Customer.retrieve(@user.stripe_id)
	customer.source = token 
	customer.save
	redirect_to root_path
end
end
