class ReviewsController < ApplicationController
  before_action :set_event

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def create
    unless @event.completed?
      redirect_to @event, alert: "Solo puedes dejar una reseña en eventos completados." and return
    end

    confirmed_registration = @event.registrations
                                   .where(user_id: current_user.id, status: "confirmed")
                                   .first

    unless confirmed_registration
      redirect_to @event, alert: "Solo los asistentes confirmados pueden dejar una reseña." and return
    end

    if @event.reviews.exists?(user_id: current_user.id)
      redirect_to @event, alert: "Ya dejaste una reseña para este evento." and return
    end

    @review = @event.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @event, notice: "¡Reseña publicada exitosamente!"
    else
      redirect_to @event, alert: "Error al guardar la reseña: #{@review.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @review = @event.reviews.find(params[:id])

    unless @review.user_id == current_user.id
      redirect_to @event, alert: "No tienes permiso para eliminar esta reseña." and return
    end

    @review.destroy
    redirect_to @event, notice: "Reseña eliminada."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end