class RegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    authorize! :create, Registration

    unless @event.published?
      redirect_to @event, alert: "You cannot register for this event." and return
    end

    existing = @event.registrations.where(user_id: current_user.id)
                     .where.not(status: "cancelled").first

    if existing
      redirect_to @event, alert: "You are already registered for this event." and return
    end

    status = @event.full? ? :waitlisted : :confirmed

    @registration = @event.registrations.build(
      user: current_user,
      status: status,
      registered_at: Time.current
    )

    if @registration.save
      if status == :confirmed
        redirect_to @event, notice: "Registration confirmed successfully."
      else
        redirect_to @event, notice: "The event is full. You have been added to the waitlist."
      end
    else
      redirect_to @event, alert: "Registration could not be completed: #{@registration.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @registration = @event.registrations.find(params[:id])
    authorize! :destroy, @registration

    was_confirmed = @registration.confirmed?

    @registration.update!(status: :cancelled)

    promote_next_waitlisted if was_confirmed

    redirect_to @event, notice: "Registration cancelled."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def promote_next_waitlisted
    next_registration = @event.registrations
                              .waitlisted
                              .order(:registered_at)
                              .first

    next_registration&.update!(status: :confirmed)
  end
end