class StudentPlansController < ApplicationController
  before_action :authenticate_user!
  def new
    @plan = Splan.new
  end
#creates a students plan on stripe
  def create
  	 @user = current_user
	   @plan = @user.splans.new(plans_params)
     
     Stripe.api_key = @user.access_code #replace with @user.access_code
     
      Stripe::Plan.create(
      :amount => @plan.amount,
      :interval => @plan.interval,
      :name => @plan.name,
      :id => @plan.stripe_id,
      :currency =>@plan.currency
      )
    
	   @plan.save
     redirect_to root_path
  		
  end

  	private

	def plans_params
	    params.require(:plan).permit(:amount,:interval,:name,:currency,:stripe_id)
	end
end
