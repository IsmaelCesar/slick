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
      let messages_content_list = document.querySelector('.messages-content-list');
      messages_content_list.innerHTML += data['message']; 
    }
  });
}
