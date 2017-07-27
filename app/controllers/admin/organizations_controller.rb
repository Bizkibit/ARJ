class Admin::OrganizationsController < Admin::BaseController
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
      flash[:notice] = 'Membership approved'
    else
      @organization.reject
      flash[:notice] = 'Membership rejected'
    end

    @organization.save
    respond_to do |format|
      format.html { redirect_to admin_panel_path }
      format.js :update_success
    end
  end
end
