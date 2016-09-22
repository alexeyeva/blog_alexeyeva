class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:edit, :update]

  def update
    if @user.update(user_params)
      render :edit, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  private

    def find_user
      @user = User.find(current_user)
    end

    def user_params
      params.require(:user).permit(:password, :first_name, :last_name)
    end
end
