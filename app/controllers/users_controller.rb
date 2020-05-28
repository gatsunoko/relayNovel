class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]
  before_action :is_mine, only: [:edit, :update]

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def update
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

    def set_user
      @user = User.find current_user.id
    end

    def is_mine
      if @user.id != current_user.id
        redirect_back(fallback_location: root_path) and return
      end
    end
end
