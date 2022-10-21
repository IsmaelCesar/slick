//import consumer from "./consumer"
import { toggle_message_answer_for_button } from "../messaging/messages/utils";
import { set_answered_message_value } from "../messaging/messages/utils";

export default function init_subscription_for_resource(consumer, resource_name, resource_id){
  return consumer.subscriptions.create({ channel: "MessagingChannel", 
                                  resource: resource_name, 
                                  id: resource_id } , {
    connected() {
      console.log("Connected to channel ", `messaging/${resource_name}/${resource_id}`)
    },

    disconnected() {
      console.log("Disconnected to channel ", `messaging/${resource_name}/${resource_id}`)
    },

    received(data) {
      let messages_content_list = document.querySelector(`#${data['messages_container_id']}`);
      if(messages_content_list){
        messages_content_list.innerHTML += data['message']; 
        let latest_message = messages_content_list.lastChild;
        if (latest_message){
          this.update_message_class(latest_message, parseInt(data['user_id']));
          this.clean_text_field_message_sent(data['user_id']);
          messages_content_list.scroll({ top: latest_message.offsetTop });
        }
      }
      else{
        console.error('Container: ', data['messages_container_id'], 'not found'); 
      }
    },

    update_message_class(latest_message, user_sender_id) {
      let user_id = document.querySelector('meta[name="user_id"]').content; 
      user_id = parseInt(user_id)
      latest_message.classList.remove('contact-message');
      let message_content_actions = latest_message.querySelector('.message-content-actions');
      message_content_actions.classList.remove('contact-message');
      if(user_id === user_sender_id){
        latest_message.classList.add('user-message');
        latest_message.querySelector('.message-content-actions').classList.add('user-message');
      }
      else{
        latest_message.classList.add('contact-message');
        latest_message.querySelector('.message-content-actions').classList.add('contact-message');
        this.remove_user_exclusive_actions_from_conainter(message_content_actions);
      }
      let btn_answer = message_content_actions.querySelector('.btn-answer-message');
      toggle_message_answer_for_button(btn_answer);
      this.remove_answer();
    },
    
    remove_user_exclusive_actions_from_conainter(actions_container){
      let btn_delete = actions_container.querySelector('.btn-danger');
      let btn_success = actions_container.querySelector('.btn-success');
      actions_container.removeChild(btn_delete); 
      actions_container.removeChild(btn_success);
    },
    
    remove_answer(){
      let answered_message_container = document.querySelector('.answered-message');
      answered_message_container?.remove();
      set_answered_message_value(null);
    },
    
    clean_text_field_message_sent(user_id){
      let text_field_send_message = document.querySelector(`.form-send-message-${user_id}`);
      if(text_field_send_message){
        text_field_send_message.reset();
      }
    }
  });
}
