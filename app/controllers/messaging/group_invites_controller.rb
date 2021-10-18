class Messaging::GroupInvitesController < Messaging::MessagingController

  before_action :set_current_user, only: [:accept, :decline]

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
    @group_invite = GroupInvite.find(params[:id])
    @group = @group_invite.group
    @user  = @group_invite.user
    @user_group = nil
    ActiveRecord::Base.transaction do
      @user_group = UserGroup.create!(user: @user, group: @group)
      @group_invite.update(is_accepted: true)
    end
    respond_to do |format|
      format.js do
        render 'messaging/group_invites/accept',
               locals: {
                 received_invites: @current_user.invites_received.where(is_accepted: [false, nil]),
                 group_invites: @current_user.group_invites.where(is_accepted: [false, nil]),
                 all_user_groups: @current_user.all_user_groups,
                 new_group_channels_ids: @user_group&.group&.text_channels&.ids
               }
      end
    end
  end

  # [DELETE] /group_invites/decline/:id
  def decline
    @group_invite = GroupInvite.find(params[:id])
    ActiveRecord::Base.transaction do
      @group_invite.delete
    end
    respond_to do |format|
      format.js do
        render 'messaging/user_invites/list_received',
               locals: {
                 received_invites: @current_user.invites_received.where(is_accepted: [false, nil]),
                 group_invites: @current_user.group_invites.where(is_accepted: [false, nil])
               }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end

  def set_current_user
    @current_user = current_user
  end

end
