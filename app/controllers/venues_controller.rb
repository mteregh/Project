class VenuesController < ApplicationController
  def index
    @venues = Venue.all
  end

  def show
    @venue = Venue.find(params[:id])
  end

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
      redirect_to venues_path, notice: "Venue was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def venue_params
    params.require(:venue).permit(:name, :location, :capacity)
  end
end