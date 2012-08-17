class BidsController < ApplicationController
	before_filter :authenticate_user!
	def index
		@bids = current_user.company.bids.order("created_at").page(params[:page]).per_page(10)
	end

	def new
		@bid = Bid.new
	end

	def show
		@bid = Bid.find(params[:id])
		@bid_item = BidItem.new
		@bid_items = @bid.bid_items.find(:all, :order => 'category')
	end

	def edit
		@bid = Bid.find(params[:id])
	end

	def update
		@bid = Bid.find(params[:id])
		if @bid.update_attributes(params[:bid])
			flash[:success] = "Bid Updated"
			redirect_to bids_path
		else
			flash[:error] = "Bid Updated"
			render 'edit'
		end
	end

	def create	
			@bid = Bid.create(params[:bid])
	    if @bid.save
	      flash[:success] = "Bid Created"
	      redirect_to bid_path(@bid)
	    else
	    	flash[:error] = "Bid Failed"
	      render 'new'
	    end
	end

	def destroy
		Bid.find(params[:id]).destroy
		flash[:success] = "Bid Deleted"
		redirect_to :back
	end
end
