class RolesController < ApplicationController

	def switch
		if @admin
			session[:admin] = "false"
		else
			session[:admin] = "true"
		end
		redirect_to "/", :notice => "Your role has been changed!"
	end
end
