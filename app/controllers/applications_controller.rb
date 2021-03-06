class ApplicationsController < ApplicationController
  before_action :find_organization

  def create
    @application = Application.new application_params
    @application.organization = @organization
    if can? :create, @application
      respond_to do |format|
        if @application.update(user: current_user)
          format.html { redirect_to organization_path(@organization), notice: 'Your request has been sent' }
          format.js { render :create_successful }
        else
          format.html { redirect_to organization_path(@organization), alert: 'an Error has occured' }
          format.js { render :create_successful }
        end
      end
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
        respond_to do |format|
          if @application.save
            format.html { redirect_to organization_path(@application.organization)}
            format.js { render 'applications/update_succ' }
          else
          end
        end
      else
        head :unauthorized
      end
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
