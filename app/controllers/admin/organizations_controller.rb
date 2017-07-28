class Admin::OrganizationsController < Admin::BaseController
  def index
    @organizations = Organization.order(created_at: :desc)
  end

  def update
    @organization = Organization.find(params[:id])

    if params[:approve]
      @organization.approve
      flash[:notice] = 'Membership approved'
    else
      @organization.reject
      flash[:notice] = 'Membership rejected'
    end

    if @organization.save
      respond_to do |format|
        format.html { redirect_to admin_organizations_path }
        format.js { update_success }
      end
    end
  end
end
