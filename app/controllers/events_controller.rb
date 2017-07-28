class EventsController < ApplicationController
  before_action :find_organization

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    @event.organization = @organization
    respond_to do |format|
      if @event.save
        format.html {redirect_to organization_path(@organization), notice: 'Event created'}
        format.js {  }
      else
        flash[:alert] = 'Event creation Error'
        render :new
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    if user_signed_in?
     @org_membership = current_user.memberships.find(@organization.id)
    end
  end

  def destroy
    event = @organization.event
    event.destroy
    flash[:notice] = 'Event cancelled'
    redirect_to organization_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end

  def event_params
    params.require(:event).permit(:start_date, :end_date, :start_time, :end_time, :details, :spots)
  end

end
