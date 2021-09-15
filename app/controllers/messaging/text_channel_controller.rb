class Messaging::TextChannelController < Messaging::MessagingController

  before_action :set_current_user

  def new
    @group = Group.find(params[:group_id])
    @text_channel = TextChannel.new(group: @group)
    respond_to do |format|
      format.js { render 'messaging/text_channel/new', locals: { text_channel: @text_channel } }
    end
  end

  def edit
  end

  def create
    @new_text_channel = TextChannel.new(text_channel_params)
    respond_to do |format|
      if @new_text_channel.save
        @new_text_channel.reload
        format.js { render 'messaging/text_channel/create',
                    locals: { group: @new_text_channel.group,
                              current_user: @current_user } }
      else
        format.js { render js: "alertify.error('#{@new_text_channel.errors.full_messages.join('\n')}')"}
      end
    end

  end

  def update
  end

  def destroy
  end

  private

  def text_channel_params 
    params.require(:text_channel).permit([TextChannel.column_names - ['created_at', 'updated_at'] ])
  end

  def set_current_user
    @current_user = current_user
  end
end
