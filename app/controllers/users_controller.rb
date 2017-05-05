class UsersController < ApplicationController
#include CanCan::ControllerAdditions
 

  def new
    @user = User.new
  end

  def edit
    @user = current_user
    #authorize! :edit, @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
    @user = current_user
    #authorize! :update, @user
    if @user.update_attributes(user_params)
      redirect_to(home_path, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :photo, :first_name, :last_name, :email, :role, :band_id, :active)
  end

end
