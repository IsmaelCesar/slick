class Messaging::UsersController < Messaging::MessagingController
  before_action :set_current_user
  def edit
    puts @current_user.inspect
  end

  def update
    ActiveRecord::Base.transaction do
      if @current_user.update(user_params)
        redirect_to messaging_users_edit_path
      else
        respond_to do |format|
          format.js { render inline: "alertify.error('#{@current_user.errors.full_messages.join('\n')}')" }
        end
      end
    end
  end

  def delete
  end

  private 
  def set_current_user
    @current_user = current_user
  end

  def user_params
    params.require(:user).permit(User.column_names - %i[id created_at updated_at])
  end
end
