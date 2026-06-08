class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    authorize! :create, Review

    unless @event.completed?
      redirect_to @event, alert: "You can only review completed events." and return
    end

    confirmed_registration = @event.registrations
                                   .where(user_id: current_user.id, status: "confirmed")
                                   .first

    unless confirmed_registration
      redirect_to @event, alert: "Only confirmed attendees can leave a review." and return
    end

    if @event.reviews.exists?(user_id: current_user.id)
      redirect_to @event, alert: "You have already reviewed this event." and return
    end

    @review = @event.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @event, notice: "Review posted successfully."
    else
      redirect_to @event, alert: "Review could not be saved: #{@review.errors.full_messages.join(', ')}"
    end
  end

  def destroy
    @review = @event.reviews.find(params[:id])

    authorize! :destroy, @review

    @review.destroy
    redirect_to @event, notice: "Review deleted."
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end