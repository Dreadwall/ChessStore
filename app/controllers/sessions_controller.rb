 class SessionsController < ApplicationController
    include ChessStoreHelpers

    def new
      if(!current_user.nil?)
        redirect_to home_path, notice: "Already Logged in!"
        return
      end
    end

    def create

      user = User.find_by_email(params[:email])
      if user && User.authenticate(params[:email], params[:password])
       begin
         a = User.find(session[:user_id])
         redirect_to user_path, notice: "User Created!"
       rescue Exception
          session[:user_id] = user.id
          create_cart
          redirect_to home_path, notice: "Logged in!"
        end
      else
        redirect_to login_path, notice: "Email or password is invalid"
      end
    end

    def destroy
      session[:user_id] = nil
      clear_cart
      destroy_cart
      redirect_to home_path, notice: "Logged out!"
    end
  end