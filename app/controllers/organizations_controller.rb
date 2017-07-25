class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_organization, only: [:show, :edit, :update]

  def index
    @organizations = Organization.approved_organizations
    # @organization =  @organizations.near([49.2819605,-123.1086604], 1000)
    @hash = Gmaps4rails.build_markers(@organizations) do |organization, marker|
      marker.lat organization.latitude
      marker.lng organization.longitude
      marker.infowindow organization.name
     end
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new organization_params
    @organization.user = current_user
    if @organization.save
      redirect_to organization_path(@organization)
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @organization.reviews.order(created_at: :desc)
    @new_application = Application.new
    @current_application = @organization.applications.find_by(user_id: current_user)
    @events = @organization.events


    @org_rating = 0
    if !@reviews.empty?
      @reviews.each do |r|
        @org_rating+= r.rating.to_i
      end
      @org_rating=@org_rating/@reviews.count
    end
  end

  def edit
  end

  def update
    if can? :update, @organization
      if @organization.update organization_params
        redirect_to organization_path(@organization)
      else
        render :edit
      end
    else
      head :unauthorized
    end
  end


  def organization_params
    params.require(:organization).permit(:name, :website, :phone, :address, :additional, pictures: [],
                                          events_attributes: [:start_date,
                                                            :end_date,
                                                            :start_time,
                                                            :end_time,
                                                            :spots,
                                                            :details ] )
  end

  private

  def find_organization
    @organization = Organization.find(params[:id])
  end

end
