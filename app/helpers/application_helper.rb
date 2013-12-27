module ApplicationHelper

	#Could monkeypath this to an existing class (FixNum?)
	def to_dollars(number=0)
		number ||= 0
		if number == 0
			'$0.00'
		else
			flt = sprintf('%.2f',(number * 0.01))
			dollars = '$'+flt.to_s
		end
	end

	def get_role(is_admin)
		return is_admin ? "Storekeeper" : "Customer"
	end
end
