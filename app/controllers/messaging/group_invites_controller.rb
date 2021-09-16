class Messaging::GroupInvitesController < ApplicationController

  # [GET] /group_invites/new
  def new
    @user = User.new
    respond_to do |format|
      format.js { render 'messaging/group_invites/new', locals: { user: @user } }
    end
  end

  # [GET] /group_invites/create
  def create
  end

  # [PUT] /group_invites/accept/:id
  def accept
  end

  # [DELETE] /group_invites/decline/:id
  def decline
  end
end
