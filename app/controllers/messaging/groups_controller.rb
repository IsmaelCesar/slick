class Messaging::GroupsController < Messaging::MessagingController

  before_action :set_group, only: %i[edit show]
  before_action :set_current_user 

  def new
    @group = Group.new
  end

  def edit
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

  def destroy
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
    @groups = Group.all
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
