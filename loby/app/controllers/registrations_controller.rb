class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to items_path
    else
      render :new
    end
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
