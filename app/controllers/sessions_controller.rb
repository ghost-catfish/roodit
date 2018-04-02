class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: login_params[:username])

    if user && user.authenticate(login_params[:password])
      login(user)
      redirect_back fallback_location: new_session_path, notice: 'Logged in'
    else
      flash.now[:notice] = 'Invalid username / password combination'
      render :new
    end
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end

  def destroy
  logout
  redirect_back fallback_location: new_session_path, notice: 'Logged out'
end

end