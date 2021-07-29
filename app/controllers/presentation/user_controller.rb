class Presentation::UserController < ApplicationController
  before_action :authorized?, only: [:login]
  before_action :set_empty_user, only: %i[login sign_up]

  def login
  end

  def sign_up
  end

  def sign_up_apply
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to presentation_user_sign_up_path
    else
      render :sign_up
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def set_empty_user
    @user = User.new
  end

  def user_params
    params.require(:user).permit(User.column_names - %i[id created_at updated_at password_digest], 
                                 :password,
                                 :password_confirmation)
  end

end
