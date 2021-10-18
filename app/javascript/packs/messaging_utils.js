/**
 * @author Ismael Cesar <leamscesar@gmail.com>
 * 
 * module dedicated to the implementation of the channel initializer
 */
import { AjaxBuilder } from './ajax_utils';
import consumer from "../channels/consumer";
import init_subscription_for_resource from "../channels/messaging_channel";

const consumer_builder = new AjaxBuilder()
//const messaging_consumer = consumer
//window.consumer = consumer
//alert('LOADED!');

window.addEventListener('load', ()=>{
  function verify_consumer_subscriptions(subscriptions, resource_name, chat_id){
    let is_subscribed = false;
    console.log(`${resource_name} id:`, chat_id);
    for(let sub of subscriptions){
      let local_sub  = JSON.parse(sub.identifier);
      is_subscribed = local_sub.resource === resource_name;
      console.log('local_sub.resource === resource_name;', is_subscribed)
      is_subscribed = is_subscribed && local_sub.id === chat_id;
      console.log('is_subscribed && local_sub.id === chat_id;', is_subscribed)
    }
    console.log(is_subscribed);
    return is_subscribed;
  }
  
  consumer_builder.get('/messaging/chats/current_user_chat_ids', (data)=>{
    // let subscriptions = consumer.subscriptions.subscriptions
    for(let chat_id of data['chat_ids']){      
        init_subscription_for_resource(consumer, 'chat', chat_id);
    }
  });
  
  consumer_builder.get('/messaging/groups/current_user_text_channel_ids', (data)=>{
    // let subscriptions = consumer.subscriptions.subscriptions
    for(let text_channel_id of data){
      init_subscription_for_resource(consumer, 'text_channel', text_channel_id);
    }
  }); 
});

