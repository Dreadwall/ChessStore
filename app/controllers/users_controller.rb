class UsersController < ApplicationController
#include CanCan::ControllerAdditions

  def new
    @user = User.new
  end

  def edit
     @user = User.find(params[:id])
    #authorize! :edit, @user
  end


  def show
    # get the price history for this item
    @user = User.find(params[:id])
    authorize! :show, @user
    # everyone sees similar items in the sidebar
    @orders = @user.orders.chronological.to_a
  end



  def create
    @user = User.new(user_params)
    if(!current_user.nil? && current_user.role != 'admin')
      @user.role = 'customer'
    end
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_school_path, notice: "Thank you for signing up! Make sure to add your School!"
    else
      flash[:error] = "This user could not be created."
      render "new"
    end
  end

  def update
     @user = User.find(params[:id])
    #authorize! :update, @user
    if @user.update_attributes(user_params)
      redirect_to(user_path(@user), :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def user_params
    params.require(:user).permit(:password, :username, :phone, :password_confirmation, :photo, :first_name, :last_name, :email, :role, :band_id, :active)
  end

end
