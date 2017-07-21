class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.approved_organizations

    @organization =  @organizations.near([49.2819605,-123.1086604], 1000)
    @hash = Gmaps4rails.build_markers(@organization) do |organization, marker|
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
    if @organization.save
      redirect_to organization_path(@organization)
    else
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
    @review = Review.new
    @reviews = @organization.reviews.order(created_at: :desc)

    @total = 0
    if !@reviews.empty?
        @reviews.each do |r|
          @total+= r.rating.to_i
        end
        @total=@total/@reviews.count
    end

    @new_application = Application.new

  end

  def edit
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
end
