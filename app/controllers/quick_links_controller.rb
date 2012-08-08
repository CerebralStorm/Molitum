class QuickLinksController < ApplicationController
  def create
    @quick_link = current_user.quick_links.build(params[:quick_link])
    if @quick_link.save
      flash[:success] = "Link Added"
      redirect_to :back
    else
      flash[:error] = "Link Failed"
      redirect_to :back
    end
  end

  def destroy
    if QuickLink.find(params[:id]).destroy
      flash[:success] = "Link Removed"
      redirect_to :back
    else
      flash[:error] = "Removal Unsuccessful"
      redirect_to :back
    end
  end
end
