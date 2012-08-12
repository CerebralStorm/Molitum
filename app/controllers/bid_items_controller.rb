class BidItemsController < ApplicationController
	before_filter :authenticate_user!
	def create
		@bid = Bid.find(params[:bid_id])
		@bid_item = @bid.bid_items.build(params[:bid_item])
	    if @bid_item.save
	      @bid.add_to_total_hours(@bid_item.hours)
	      @bid.add_to_total_materials(@bid_item.materials)
	      @bid.add_to_subtotal(@bid_item.materials)
	      @bid.compute_subtotal
	      @bid.save
	      redirect_to :back
	    else
	      redirect_to :back
	    end
	end

	def destroy
		@bid_item = BidItem.find(params[:id])
		@bid_item.bid.subtract_from_total_hours(@bid_item.hours)
	  @bid_item.bid.subtract_from_total_materials(@bid_item.materials)
	  @bid_item.bid.compute_subtotal
	  @bid_item.bid.save
		if @bid_item.destroy
			redirect_to :back
		else
			redirect_to :back
		end
	end
end
