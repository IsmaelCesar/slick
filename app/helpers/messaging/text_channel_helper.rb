module Messaging::TextChannelHelper
  def infer_form_url_based_on_record(text_channel) 
    if text_channel.new_record?
      messaging_text_channel_index_path
    else
      messaging_text_channel_path(text_channel.id)
    end
  end
end
