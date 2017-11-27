class Api::V1::OrganizationsController < Api::ApplicationController
  before_action :authenticate_user!
  before_action :find_organization, only: [:show]

  def index
    # render json: current_user
    render json: Organization.approved
  end

  def show
    render json:@organization
  end

  private

  def find_organization
    @organization = Organization.find(params[:id])
  end
end
