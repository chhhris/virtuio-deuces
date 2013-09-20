class SessionsController < ApplicationController

  rescue_from ActionView::MissingTemplate do |exception|
    flash.now.alert = "Email or password is invalid."
  end

  def new
  end

  def create
  	user = User.find_by_email(params[:email])

   	if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(current_user), notice: "Welcome, #{user.name}."
	  else
      flash[:notice] = 'Email or password is invalid'
      render action: 'new'
  	end
    
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Successfully logged out."
  end
end