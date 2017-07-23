class ReviewsController < ApplicationController
  before_action :authenticate_user!
  def create
    @organization = Organization.find(params[:organization_id])
    @review = Review.new review_params
    @review.organization = @organization
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Review created'
      redirect_to organization_path(@organization)
    else
      flash[:alert] = 'Couldnt create review'
      render 'organizations/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    flash[:notice]= 'Review deleted'
    redirect_to organization_path(@review.organization)
  end

  private

  def review_params
    params.require(:review).permit(:body, :star)
  end
end
