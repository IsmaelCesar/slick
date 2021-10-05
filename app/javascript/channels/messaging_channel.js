//import consumer from "./consumer"

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
    },
    remove_user_exclusive_actions_from_conainter(actions_container){
      console.log(actions_container);
      let btn_delete = actions_container.querySelector('.btn-danger');
      let btn_success = actions_container.querySelector('.btn-success');
      actions_container.removeChild(btn_delete); 
      actions_container.removeChild(btn_success);
    }
  });
}
