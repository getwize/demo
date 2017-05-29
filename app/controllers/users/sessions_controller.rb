class Users::SessionsController < Devise::SessionsController
	layout 'signin', only: [:new]

	def after_sign_in_path_for(resource)
		'/pages/home'
	end

	def after_sign_out_path_for(resource)
		'/users/sign_in'
	end
end