class Messaging::TextChannelController < Messaging::MessagingController

  before_action :set_current_user

  def new
    @group = Group.find(params[:group_id])
    @text_channel = TextChannel.new(group: @group)
    respond_to do |format|
      format.js { render 'messaging/text_channel/new', locals: { text_channel: @text_channel } }
    end
  end


  def show
    @text_channel = TextChannel.find(params[:id])

    @messages = @text_channel.text_channel_messages
    respond_to do |format|
      format.js do
        render 'messaging/text_channel/show',
               locals: {
                 messages: @messages,
                 current_user: @current_user,
                 resource_header: @text_channel.name,
                 messages_container_id: "text-channel-#{@text_channel.id}",
                 resource_url: messaging_send_text_channel_message_path(@text_channel.id)
               }
      end
    end
  end

  def edit
    @text_channel = TextChannel.find(params[:id])
    respond_to do |format|
      format.js { render 'messaging/text_channel/new', locals: { text_channel: @text_channel } }
    end
  end

  def create
    @new_text_channel = TextChannel.new(text_channel_params)
    respond_to do |format|
      if @new_text_channel.save
        @new_text_channel.reload
        format.js do
          render 'messaging/text_channel/update_text_channel_list',
                 locals: {
                   group: @new_text_channel.group,
                   current_user: @current_user
                 }
        end
      else
        format.js { render js: "alertify.error('#{@new_text_channel.errors.full_messages.join('\n')}')"}
      end
    end

  end

  def update
    @text_channel = TextChannel.find(params[:id])
    @group = @text_channel.group
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @text_channel.update(text_channel_params)
          format.js do
            render 'messaging/text_channel/destroy',
                   locals: {
                     group: @group,
                     current_user: @current_user
                   }
          end
        else
          format.js { render js: "alertify.error('#{@text_channel.errors.full_messages.join('\n')}')" }
        end
      end
    end
  end

  def destroy
    @text_channel = TextChannel.find(params[:id])
    @group = @text_channel.group
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @text_channel.destroy
          format.js do
            render 'messaging/text_channel/destroy',
                   locals: {
                     group: @group,
                     current_user: @current_user
                   }
          end
        else
          format.js { render js: "alertify.error('#{@text_channel.errors.full_messages.join('\n')}')" }
        end
      end
    end
  end

  private

  def text_channel_params 
    params.require(:text_channel).permit([TextChannel.column_names - ['created_at', 'updated_at'] ])
  end

  def set_current_user
    @current_user = current_user
  end
end
