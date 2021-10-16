class Messaging::MessagesController < Messaging::MessagingController
  before_action :set_message

  # [GET] messages/edit/:id
  def edit
    respond_to do |format|
      format.js { render 'messaging/messages/edit', locals: { message: @message } }
    end
  end

  # [PUT] messages/put/:id
  def update
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @message.update(message_params)
          format.js { render 'messaging/messages/update', locals: { message: @message } }
        else
          puts "Erro"
          puts @message.errors.full_messages
          format.js { render inline: 'alertify.error(\"Erro when updating a message\")' }
        end
      end
    end
  end

  # [DELETE] messages/destroy/:id
  def destroy
    ActiveRecord::Base.transaction do
      respond_to do |format|
        if @message.delete
          format.js { render 'messaging/messages/destroy', message_id: @message.id }
        else
          format.js do
            render inline: 'alertify.error(\"There has been a problem when deleting this message, please contact support\")'
          end
        end
      end
    end
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(Message.column_names - %i[created_at updated_at])
  end

end
