class Admin::OrganizationsController < Admin::BaseController
  def index
    @organizations = Organization.order(created_at: :desc)
  end

  def update
    @organization = Organization.find(params[:id])

    if params[:approve]
      @organization.approve
      @organization.save
      flash[:notice] = 'Membership approved'
    else
      @organization.reject
      @organization.save
      flash[:notice] = 'Membership rejected'
    end

    redirect_to admin_organizations_path
  end
end
