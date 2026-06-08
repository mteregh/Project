# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, Event, status: "published"
    can :read, Category
    can :read, Venue
    can :read, Review

    return unless user.persisted?

    if user.admin?
      can :manage, :all
    else
      can :create, Event
      can [:update, :destroy, :publish, :cancel], Event, user_id: user.id

      can :create, Registration
      can :destroy, Registration, user_id: user.id

      can :create, Review
      can :destroy, Review, user_id: user.id

      can :read, User, id: user.id
    end
  end
end