class PagesController < ApplicationController
	before_action :authenticate_user!

	def home
		@users = User.all
	end

	def about
	end

	def contact
	end

	def blog
	end
end
