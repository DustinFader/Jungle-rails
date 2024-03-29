class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    # If the user exists
    if user
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/', notice: 'Succesfully logged in!'
    else
    # If user's login doesn't work, renew login form.
      flash.now[:alert] = 'Invalid email/password combination'
      render: new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login', notice: 'successfully logged out'
  end
end
