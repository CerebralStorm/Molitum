module BidsHelper
	
	def remember_bid(bid)
		session[:bid_token] = @bid.id
	end

	def current_bid
		session[:bid_token]
	end
	
end
