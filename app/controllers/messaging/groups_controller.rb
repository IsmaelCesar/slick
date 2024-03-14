class Messaging::GroupsController < Messaging::MessagingController

  before_action :set_group, only: %i[edit show destroy update join leave]
  before_action :set_current_user 

  def new
    @group = Group.new
  end

  def edit
  end

  # [PUT] /messaging/groups/update/:id
  def update
    if @current_user.id == @group.user_adm.id
      if @group.update(group_params)
        redirect_to messaging_groups_show_path(@group)
      end
    end
  end

  def show
  end

  def create 
    @group = Group.new(group_params)
    @group.user_adm = @current_user
    if @group.save!
      @group.reload
      redirect_to messaging_groups_show_path(@group.id)
    else
      render :new
    end
  end

  # [DELETE] /messaging/groups/delete/:id
  def destroy
    if @current_user.id == @group.user_adm.id
      if @group.destroy
        redirect_to messaging_chats_index_path
      end
    end
  end

  # [GET] groups/current_user_text_channel_ids
  def current_user_text_channel_ids
    text_channel_ids = []
    current_user.all_user_groups.each do |group|
      group.text_channels.each do |text_channel|
        text_channel_ids.append text_channel.id
      end
    end

    respond_to do |format|
      format.json { render json: text_channel_ids }
    end
  end

  def user_groups
    @user_groups = current_user.owned_groups
  end

  def available_groups
    @groups = Group
              .left_joins(:user_groups)
              .where('user_adm_id != :user_adm_id', { user_adm_id: @current_user.id })
              .where(user_groups: { user: nil })
  end

  # [GET] groups/join/:id
  def join
    @user_group = UserGroup.new(user: @current_user, group: @group)
    ActiveRecord::Base.transaction do
      if @user_group.save
        redirect_to messaging_groups_show_path(@group.id)
      else
        respond_to do |format|
          format.js { render js: 'alertify.alert(\'Error\',\'There has been a problem when joining the group\')'}
        end
      end
    end
  end

  # [DELETE] groups/leave/:id
  def leave
    @user_group = UserGroup.find_by(user: @current_user, group: @group)
    ActiveRecord::Base.transaction do
      if @user_group.delete
        redirect_to messaging_groups_available_groups_path
      else
        respond_to do |format| 
          format.js { render js: 'alertify.alert(\'Error\', \'There has been an error when leaving the group\')'}
        end
      end
    end
  end

  private

  def group_params
    params.require(:group).permit(%i[id name description group_image_url])
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def set_current_user
    @current_user = current_user
  end

end
