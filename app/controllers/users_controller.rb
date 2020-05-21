class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def show
  end

  def edit
    @user = User.find current_user.id
  end

  def update
    @user = User.find current_user.id
    if @user.update(user_params)
      # redirect_to user_path(current_user.id)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
