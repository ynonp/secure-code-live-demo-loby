class SessionsController < ApplicationController
  def new
    return redirect_to items_path if signed_in?
    @user = User.new
  end

  def create
    email     = params[:user][:email]
    password  = params[:user][:password]
    user      = User.find_by(:email => email)

    if user&.authenticate(password)
      sign_in(user)
      redirect_to items_path
    else
      @error = true
      @user = User.new
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
