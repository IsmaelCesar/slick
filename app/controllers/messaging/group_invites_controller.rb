class Messaging::GroupInvitesController < ApplicationController

  # [GET] /group_invites/new
  def new
    @user = User.new
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.js { render 'messaging/group_invites/new', locals: { user: @user, group: @group } }
    end
  end

  # [POST] /group_invites/create
  def create
    @is_succesful = false
    @group = Group.find(params[:group_id])
    @message = ''
    if !user_params[:email].empty?
      @user = User.find_by(email: user_params[:email])
      if @user
        ActiveRecord::Base.transaction do
          @group_invite = GroupInvite.new(user: @user, group: @group)
          if @group_invite.save
            @is_succesful = true
            @message = 'Invite successfully sent'
          else
            @message = @group_invite.errors.full_messages.join('\n').to_s
          end
        end
      else
        @message = 'User not found'
      end
    else
      @message = 'An empty email was sent as parameter'
    end

    respond_to do |format|
      format.js  { render js: "alertify.#{@is_succesful ? 'success' : 'error'}('#{@message}');"}
    end
    
  end

  # [PUT] /group_invites/accept/:id
  def accept
  end

  # [DELETE] /group_invites/decline/:id
  def decline
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

end
