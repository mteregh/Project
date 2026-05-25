class RegistrationsController < ApplicationController
  before_action :set_event

  def index
    @registrations = Registration.all
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def create
    unless @event.published?
      redirect_to @event, alert: "No puedes registrarte en este evento." and return
    end

    existing = @event.registrations.where(user_id: current_user.id)
                     .where.not(status: "cancelled").first
    if existing
      redirect_to @event, alert: "Ya estás registrado en este evento." and return
    end

    status = @event.full? ? :waitlisted : :confirmed

    @registration = @event.registrations.build(
      user: current_user,
      status: status,
      registered_at: Time.current
    )

    if @registration.save
      if status == :confirmed
        redirect_to @event, notice: "¡Registro confirmado exitosamente!"
      else
        redirect_to @event, notice: "El evento está lleno. Fuiste agregado a la lista de espera."
      end
    else
      redirect_to @event, alert: "No se pudo completar el registro: #{@registration.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @registration = @event.registrations.find(params[:id])

    unless @registration.user_id == current_user.id
      redirect_to @event, alert: "No tienes permiso para cancelar este registro." and return
    end

    was_confirmed = @registration.confirmed?

    @registration.update!(status: :cancelled)

    if was_confirmed
      promote_next_waitlisted
    end

    redirect_to @event, notice: "Registro cancelado."
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