class Messaging::TextThreadsController < Messaging::MessagingController

  before_action :set_text_thread, only:  %i[show edit destroy]

  before_action :set_current_user

  def show
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @text_thread.save
          format.js do
            render 'messaging/text_threads/show',
                   locals: {
                     messages: @text_thread.text_thread_messages,
                     current_user: @current_user,
                     resource_header: @text_thread.label,
                     messages_container_id: "text-thread-#{@text_thread.id}",
                     resource_url: messaging_send_text_thread_message_path(@text_thread.id),
                     text_thread: @text_thread
                   }
          end
        else
          format.js { render js: "alertify.error(\'#{@text_thread.errors.full_messages.join('\n')}\')" }
        end
      end
    end
  end

  def create
    @text_channel_message = TextChannelMessage.find(params[:text_channel_message_id])
    @text_channel = @text_channel_message.text_channel
    text_threads_number = @text_channel.text_threads.size
    @text_thread = TextThread.new(label: "Text thread - #{text_threads_number + 1}",
                                  text_channel_message: @text_channel_message,
                                  text_channel: @text_channel)
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @text_thread.save
          format.js do
            render 'messaging/text_threads/show',
                   locals: {
                     messages: @text_thread.text_thread_messages,
                     current_user: @current_user,
                     resource_header: @text_thread.label,
                     messages_container_id: "text-thread-#{@text_thread.id}",
                     resource_url: messaging_send_text_thread_message_path(@text_thread.id),
                     text_thread: @text_thread
                   }
          end
        else
          format.js { render js: "alertify.error(\'#{@text_thread.errors.full_messages.join('\n')}\')" }
        end
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @text_thread.delete
          format.js { render 'messaging/text_threads/destroy', locals: { text_thread: @text_thread } }
        else
          format.js { render js: "alertify.error(\'#{@text_thread.errors.full_messages.join('\n')}\')" }
        end
      end
    end
  end

  private

  def set_current_user
    @current_user = current_user
  end

  def set_text_thread
    @text_thread = TextThread.find(params[:id])
  end

end
