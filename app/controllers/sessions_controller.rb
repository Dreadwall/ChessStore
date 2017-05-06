 class SessionsController < ApplicationController
    include ChessStoreHelpers

    def new
    end

    def create
      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
        session[:user_id] = user.id
        create_cart
        redirect_to home_path, notice: "Logged in!"
      else
        redirect_to login_path, notice: "Email or password is invalid"
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"
    end
  end