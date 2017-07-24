class Admin::OrganizationsController < ApplicationController
  def index
    @organizations = Organization.order(created_at: :desc)
    @pending = Organization.where(aasm_state: 'pending')
    @approved = Organization.where(aasm_state: 'approved')
    @rejected = Organization.where(aasm_state: 'rejected')
  end

  def update
    @organizations = Organization.all
    @organization = Organization.find(params[:organization_id])
    if params[:id] == '1'
      @organization.approve
      @organization.save
      flash[:notice] = 'Membership approved'
    else
      @organization.reject
      @organization.save
      flash[:notice] = 'Membership rejected'
    end
    redirect_to admin_panel_path
  end
end
