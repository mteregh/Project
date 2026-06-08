class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    authorize! :manage, User
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    unless current_user.admin? || current_user == @user
      redirect_to root_path, alert: "You are not authorized to view this profile."
    end
  end
end