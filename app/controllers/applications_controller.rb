class ApplicationsController < ApplicationController
  before_action :find_organization

  def create
    @application = Application.new application_params
    # @application.update(user: current_user, organization: @organization)
    @application.organization = @organization
    if can? :create, @application
      if @application.update(user: current_user)
        flash[:notice] = 'Your request has been sent'
      else
        flash[:alert] = 'an Error has occured'
      end
      redirect_to organization_path(@organization)
    else
      head :unauthorized
    end
  end

  def update
    @application = Application.find(params[:application_id])
      if can? :update, @application
        if params[:id] == '1'
          @application.approve
          flash[:notice] = 'Membership approved'
        else
          @application.reject
          flash[:notice] = 'Membership rejected'
        end
        @application.save
      else
        head :unauthorized
      end
    redirect_to organization_path(@application.organization)
  end

  def destroy
    application = @organization.applications.find_by(user: current_user)
    if application.destroy
      flash[:notice] = 'Membership cancelled'
    else
      flash[:alert] = 'Error'
    end
    redirect_to organization_path(@organization)
  end

  private

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end

  def application_params
    params.require(:application).permit(:detail)
  end
end
