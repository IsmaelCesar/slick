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
    @create_message = 'usuário não encontrado'
    if !@invitee.nil?
      @user_invite = UserInvite.new(inviter: @inviter, invitee: @invitee)
      unless @user_invite.save
        @status = :unprocessable_entity
        @create_message = "Usuário inválido \n #{Contact.errors.full_messages.join('\n')}"
      end
    else
      @status = :not_found
      @create_message = 'Usuário não encontrado'
    end
    respond_to do |format|
      #@pending_invites = @inviter.invites_sent.where(is_accepted: false)
      #format.js { render 'messaging/user_invites/list_pending', locals: { pending_invites: @pending_invites } }
      format.json { render json: { messagem: @create_message }, status: @status } 
    end
  end
  
  # [PUT] /messaging/user_invites/accept/:id
  def accept
    @user_invite = UserInvite.find(params[:id])
    Contact.create(user: @user_invite.inviter, user_contact: @user_invite.invitee)
    Contact.create(user: @user_invite.invitee, user_contact: @user_invite.inviter)
    @user_invite.update(is_accepted: true)
    respond_to do |format|
      @received_invites = current_user.invites_received.where(is_accepted: [false, nil])
      format.js { render 'messaging/user_invites/list_received', locals: { received_invites: @received_invites } }
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
