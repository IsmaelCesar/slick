class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])
    if !@user.nil? && @user.authenticate(user_params[:password])
      user_login(@user)
      redirect_to messaging_contacts_index_path
    else
      @error_message = 'Invalid user or password'
      params[:controller] = 'presentation/user'
      render 'presentation/user/login'
    end
  end

  def destroy
    user_logout
    redirect_to presentation_user_login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
