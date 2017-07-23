class AttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    new_attendance = Attendance.new({user: current_user, event: event})
    # if event.attendees << current_user
    if new_attendance.save
      flash[:notice] = 'You have successfully signed up to the event'
    else
      flash[:alert] = 'You have signed up already'
    end
    redirect_to organization_path(event.organization)
  end

  def destroy
    event = Event.find(params[:event_id])
    attendance = event.attendances.find_by(user_id: current_user)
    attendance.destroy
    flash[:notice] = 'your attendance has been cancelled'
    redirect_to organization_path(event.organization)
  end
end
