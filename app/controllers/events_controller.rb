class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :publish, :cancel]

  def index
    @events = Event.all
  end

  def show
    @registrations_count = @event.registrations.confirmed.count
    @available_spots     = @event.available_spots
    @reviews             = @event.reviews.includes(:user)

    @user_registration = @event.registrations
                               .where(user_id: current_user&.id)
                               .where.not(status: "cancelled")
                               .first
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.status = :draft

    if @event.save
      redirect_to @event, notice: "Event created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless @event.user_id == current_user&.id
      redirect_to @event, alert: "You do not have permission to edit this event." and return
    end
  end

  def update
    unless @event.user_id == current_user&.id
      redirect_to @event, alert: "You do not have permission to edit this event." and return
    end

    if @event.update(event_params)
      redirect_to @event, notice: "Event updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @event.user_id == current_user&.id
      redirect_to events_path, alert: "You do not have permission to delete this event." and return
    end

    @event.destroy
    redirect_to events_path, notice: "Event deleted."
  end

  def publish
    unless @event.user_id == current_user&.id
      redirect_to @event, alert: "You do not have permission to publish this event." and return
    end

    unless @event.draft?
      redirect_to @event, alert: "Only draft events can be published." and return
    end

    if @event.publish!
      redirect_to @event, notice: "Event published successfully."
    else
      redirect_to @event, alert: "The event could not be published."
    end
  end

  def cancel
    unless @event.user_id == current_user&.id
      redirect_to @event, alert: "You do not have permission to cancel this event." and return
    end

    unless @event.draft? || @event.published?
      redirect_to @event, alert: "This event cannot be cancelled." and return
    end

    @event.cancel!
    redirect_to @event, notice: "Event cancelled. All registrations were cancelled."
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :title, :description, :category_id, :venue_id,
      :start_date, :end_date, :max_attendees
    )
  end
end