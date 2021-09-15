class Messaging::UserInvitesController < Messaging::MessagingController

  # [GET] /messaging/user_invites/new
  def new
  end

  # [GET] /messaging/user_invites/list_received
  def list_received
    @usuario = current_user
    @received_invites = @usuario.invites_received.where(is_accepted: [false, nil])
    respond_to do |format|
      format.js { render 'messaging/user_invites/list_received', locals: { received_invites: @received_invites } }
    end
  end

  # [GET] /messaging/user_invites/list_pending
  def list_pending
    @usuario = current_user
    @pending_invites = @usuario.invites_sent.where(is_accepted: [false, nil])
    respond_to do |format|
      format.js { render 'messaging/user_invites/list_pending', locals: { pending_invites: @pending_invites } }
    end
  end

  # [POST] /messaging/user_invites/create
  def create
    puts params
    @inviter = current_user
    @invitee = User.find_by(email: params[:user_email])
    @status = :ok
    @create_message = 'Invite successfuly sent'
    if !@invitee.nil?
      @user_invite = UserInvite.new(inviter: @inviter, invitee: @invitee)
      unless @user_invite.save
        @status = :unprocessable_entity
        @create_message = "Invalid user \n #{Contact.errors.full_messages.join('\n')}"
      end
    else
      @status = :not_found
      @create_message = 'User not found'
    end
    respond_to do |format|
      format.json { render json: { message: @create_message }, status: @status } 
    end
  end
  
  # [PUT] /messaging/user_invites/accept/:id
  def accept
    @user_invite = UserInvite.find(params[:id])
    ActiveRecord::Base.transaction do
      @chat = Chat.create(user: @user_invite.invitee, contact: @user_invite.inviter)
      Friend.create(user: @user_invite.inviter, friend: @user_invite.invitee, chat: @chat)
      Friend.create(user: @user_invite.invitee, friend: @user_invite.inviter, chat: @chat)
      @user_invite.update(is_accepted: true)
    end

    @chats = current_user.chats
    respond_to do |format|
      @received_invites = current_user.invites_received.where(is_accepted: [false, nil])
      format.js { render 'messaging/user_invites/update_received_invites_and_friends', locals: { received_invites: @received_invites, 
                                                                                                 chats: @chats} }
    end
  end

  # [DELETE] /messaging/user_invites/accept/:id
  def decline
    @user_invite = UserInvite.find(params[:id])
    @user_invite.delete
    respond_to do |format|
      @received_invites = current_user.invites_received.where(is_accepted: true)
      format.js { render 'messaging/user_invites/list_received', locals: { received_invites: @received_invites } }
    end
  end
end
